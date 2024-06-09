import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InvestmentsModel {
  final List<Investment> investments = [];

  void addInvestment(String ticker, double quantity, double price) {
    final index = investments.indexWhere((investment) => investment.ticker == ticker);
    if (index != -1) {
      final existingInvestment = investments[index];
      final totalQuantity = existingInvestment.quantity + quantity;
      final totalCost = (existingInvestment.averagePrice * existingInvestment.quantity) + (price * quantity);
      existingInvestment.averagePrice = totalCost / totalQuantity;
      existingInvestment.quantity = totalQuantity;
    } else {
      investments.add(Investment(ticker: ticker, quantity: quantity, averagePrice: price));
    }
    saveInvestments();
  }

  Future<void> loadInvestments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? investmentsJson = prefs.getString('investments');
    if (investmentsJson != null) {
      final List<dynamic> decoded = json.decode(investmentsJson);
      investments.clear();
      investments.addAll(decoded.map((investment) => Investment.fromJson(investment)));
    }
  }

  Future<void> saveInvestments() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(investments.map((investment) => investment.toJson()).toList());
    await prefs.setString('investments', encodedData);
  }
}

class Investment {
  String ticker;
  double quantity;
  double averagePrice;

  Investment({required this.ticker, required this.quantity, required this.averagePrice});

  Map<String, dynamic> toJson() => {
        'ticker': ticker,
        'quantity': quantity,
        'averagePrice': averagePrice,
      };

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        ticker: json['ticker'],
        quantity: json['quantity'],
        averagePrice: json['averagePrice'],
      );
}