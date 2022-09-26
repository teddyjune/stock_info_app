import 'package:hive/hive.dart';

import 'company_listing_entity.dart';

class StockDao {
  static const companyListing = 'companyListing';
  final box = Hive.box('stock.db');

  //추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(companyListing, companyListingEntity);
  }

  //클리어
  Future clearCompanyListings() async {
    await box.clear();
  }

//검색
  Future<List<CompanyListingEntity>> searchCompanyListings(String query) async {
    final List<CompanyListingEntity> companyListing =
        box.get(StockDao.companyListing, defaultValue: []);
    return companyListing
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
