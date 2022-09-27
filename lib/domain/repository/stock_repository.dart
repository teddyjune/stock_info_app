import 'package:stock_info_app/domain/model/company_listing.dart';

import '../../util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
}
