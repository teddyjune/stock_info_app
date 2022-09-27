import 'package:stock_info_app/data/csv/company_listings_parser.dart';
import 'package:stock_info_app/data/mapper/company_mapper.dart';
import 'package:stock_info_app/data/source/remote/stock_api.dart';
import 'package:stock_info_app/domain/model/company_listing.dart';
import 'package:stock_info_app/domain/repository/stock_repository.dart';
import 'package:stock_info_app/util/result.dart';

import '../source/local/stock_dao.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _parser = CompanyListingsParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    //캐시에서 찾는다
    final localListings = await _dao.searchCompanyListings(query);

    //없다면 리모트에서 가져온다
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    if (shouldJustLoadFromCache) {
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList());
    }
    //리모트
    try {
      final response = await _api.getListings();
      final remoteListings = await _parser.parse(response.body);

      //캐시 비우기(아니면 기존의 캐시에 계속 추가)
      await _dao.clearCompanyListings();

      //캐싱(DB에 넣어야 한다)
      await _dao.insertCompanyListings(
          remoteListings.map((e) => e.toCompanyListingEntity()).toList());

      return Result.success(remoteListings);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패!!'));
    }
  }
}
