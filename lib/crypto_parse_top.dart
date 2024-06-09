import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoCurrency {
  final String name;
  final String symbol;
  final double currentPrice;
  final String imageUrl;

  CryptoCurrency({
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.imageUrl,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: json['current_price'].toDouble(),
      imageUrl: json['image'],
    );
  }
}


Future<List<CryptoCurrency>> fetchTopCryptos() async {
  final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1'));

  if (response.statusCode == 200) {
    List<dynamic> cryptosJson = json.decode(response.body);
    return cryptosJson.map((json) => CryptoCurrency.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load top cryptos');
  }
}