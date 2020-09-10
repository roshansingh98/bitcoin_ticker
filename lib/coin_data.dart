import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/cupertino.dart';

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

const apiKey = 'YOUR API KEY HERE';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getConversionRates(String currency) async {
    List<double> convertedData = [];

    for (String crypto in cryptoList) {
      var url = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';

      var conversionData = await Networking(url: url).getData();

      convertedData.add(conversionData);
    }

    return convertedData;
  }
}
