import 'package:stock_info_app/domain/model/company_listing.dart';

import '../../util/result.dart';
import '../model/company_info.dart';
import '../model/intraday_info.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );

  Future<Result<CompanyInfo>> getCompanyInfo(String symbol);

  Future<Result<List<IntradayInfo>>> getIntradayInfo(String symbol);
}
