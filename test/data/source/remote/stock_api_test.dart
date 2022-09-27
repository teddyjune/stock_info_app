import 'package:flutter_test/flutter_test.dart';
import 'package:stock_info_app/data/csv/company_listings_parser.dart';
import 'package:stock_info_app/data/source/remote/stock_api.dart';

void main() {
  test('네트워크 통신', () async {
    final _parser = CompanyListingsParser();
    final response = await StockApi().getListings();
    final remoteListings = await _parser.parse(response.body);

    expect(remoteListings[0].symbol, 'A');
    expect(remoteListings[0].name, 'Agilent Technologies Inc');
    expect(remoteListings[0].exchange, 'NYSE');
  });
}