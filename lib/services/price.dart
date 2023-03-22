import 'network.dart';

const String apiKey = "577E850F-C262-40D7-B570-A1E81BB86C93";
const String cryptoURL = "https://rest.coinapi.io/v1/exchangerate";

class CryptoPrice {
  Future<dynamic> getPrice(String cryptoCurrency, String rwCurrency) async {
    var url = "$cryptoURL/$cryptoCurrency/$rwCurrency?apikey=$apiKey";
    Networking networking = Networking(url);

    var price = await networking.getData();
    return price;
  }
}
