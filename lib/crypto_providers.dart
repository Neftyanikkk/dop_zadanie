import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'crypto_service.dart';

// Провайдер для CryptoService
final cryptoServiceProvider = Provider<CryptoService>((ref) {
  return CryptoService();
});

// Провайдер для данных о криптовалюте
final cryptoDataProvider = FutureProvider<Crypto>((ref) async {
  final cryptoService = ref.read(cryptoServiceProvider);
  return cryptoService.fetchCryptoData();
});