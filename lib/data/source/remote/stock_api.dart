import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = 'IOIE7DCAS6PSSE7C';

  final http.Client client;

  StockApi(this.client);

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await client.get(Uri.parse(
        'https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=$apiKey'));
  }
}
