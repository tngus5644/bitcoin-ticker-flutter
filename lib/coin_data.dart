import 'dart:convert';

import 'package:http/http.dart' as https;

const apiKey = '3E7AA05C-311E-4E67-AFA8-4C97146C7174';
const url = "https://rest.coinapi.io/v1/exchangerate";
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData();

  double rate;

  Future<Map> getCoinData(String currency) async {
    Map cryptoMap = {};
    for (String i in cryptoList) {
      var response = await https.get('$url/$i/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        rate = jsonDecode(response.body)["rate"];
        cryptoMap[i] = rate;
      } else
        print(response.statusCode);
    }
    return cryptoMap;
  }
}
