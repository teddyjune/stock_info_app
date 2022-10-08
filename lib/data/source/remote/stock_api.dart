import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_info_app/data/source/remote/dto/company_info_dto.dart';

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = 'IOIE7DCAS6PSSE7C';

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  //옵션 처리, 아무 것도 안 들어가면 디폴트 처리

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await _client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo({
    required String symbol,
    String apiKey = apiKey,
  }) async {
    final response = await _client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }
}
