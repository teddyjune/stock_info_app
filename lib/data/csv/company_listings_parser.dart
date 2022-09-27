import 'package:csv/csv.dart';
import 'package:stock_info_app/data/csv/csv_parser.dart';
import 'package:stock_info_app/domain/model/company_listing.dart';

class CompanyListingsParser implements CsvParser<CompanyListing> {
  @override
  Future<List<CompanyListing>> parse(String csvString) async {
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);

    csvValues.removeAt(0);
    //타이틀이 들어간 첫 번째 데이터를 날림
    return csvValues
        .map((e) {
          final symbol = e[0] ?? '';
          final name = e[1] ?? '';
          final exchange = e[2] ?? '';
          return CompanyListing(
            symbol: symbol,
            name: name,
            exchange: exchange,
          );
        })
        .where((e) =>
            e.symbol.isNotEmpty && e.name.isNotEmpty && e.exchange.isNotEmpty)
    // 데이터가 세 가지 모두 있는 것만 리스트로 변환(where 조건을 필터링하는 함수)
        .toList();
  }
}
