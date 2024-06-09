// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'crypto_parse_top.dart';
import 'crypto_bag.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: theme.themeMode, // Используйте ThemeMode из ThemeModel
          home: HomeScreen(),
        );
      },
    );
  }
}
Future<File> downloadAndSaveGif(String url, String fileName) async {
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(url);
  final dir = await getApplicationDocumentsDirectory();
  final savedFile = File('${dir.path}/$fileName');
  await file.copy(savedFile.path);
  return savedFile;
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gifUrl = 'https://drive.google.com/uc?export=view&id=1pXk77trRyFCfNfcUkyiQbPZKgfKC3mzM';


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            FutureBuilder<File>(
              future: downloadAndSaveGif(gifUrl, 'localGif.gif'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Image.file(
                    snapshot.data!,
                    height: 30.0,
                    width: 30.0,
                  );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(width: 10),
            Text(
              'OctoScreener',
              style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 35, // Размер текста
                    ),
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Изменено здесь
          children: <Widget>[
            ElevatedButton(
              // ignore: sort_child_properties_last
              child: Text(
                'Криптовалюты',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Жирный
                  fontSize: 20, // Размер текста
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CryptoScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Скругление углов
                ),
                fixedSize: Size(350, 170), // Задаем размер кнопки
              ),
            ),
            SizedBox(height: 10), // Добавляем отступ между кнопками
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: Text(
                    'Новости',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 20, // Размер текста
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 170),
                  ),
                ),
                ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: Text(
                    'Настройки',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 20, // Размер текста
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 170),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Криптовалюты',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Жирный
            fontSize: 25,
            ),  // Размер текста
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              // ignore: sort_child_properties_last
              child: Text(
                'Топ криптовалют',
                style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 20, // Размер текста
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopCryptosScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Скругление углов
                ),
                fixedSize: Size(350, 170), // Задаем размер кнопки
              ),
            ),
            SizedBox(height: 10), // Добавляем отступ между кнопками
            ElevatedButton(
              // ignore: sort_child_properties_last
              child: Text(
                'Мои инвестиции',
                style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 20, 
                ),// Размер текста
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyInvestmentsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Скругление углов
                ),
                fixedSize: Size(350, 170), // Задаем размер кнопки
              ),
            ),
            SizedBox(height: 350), // Добавляем отступ между кнопками

          ],
        ),
      ),
    );
  }
}

class TopCryptosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Топ криптовалют',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Жирный
            fontSize: 25, // Размер текста
          ),
        ),
      ),
      body: FutureBuilder<List<CryptoCurrency>>(
        future: fetchTopCryptos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CryptoCurrency crypto = snapshot.data![index];
                return ListTile(
                  leading: Image.network(crypto.imageUrl),
                  title: Text(crypto.name),
                  subtitle: Text(crypto.symbol.toUpperCase()),
                  trailing: Text('\$${crypto.currentPrice.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CryptoDetailScreen(crypto: crypto),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MyInvestmentsScreen extends StatefulWidget {
  @override
  _MyInvestmentsScreenState createState() => _MyInvestmentsScreenState();
}

class _MyInvestmentsScreenState extends State<MyInvestmentsScreen> {
  final _tickerController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final InvestmentsModel _investmentsModel = InvestmentsModel();

  @override
  void initState() {
    super.initState();
    _loadInvestments();
  }

  void _loadInvestments() async {
    await _investmentsModel.loadInvestments();
    setState(() {});
  }

  void _addInvestment() {
    final ticker = _tickerController.text.toUpperCase();
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    if (ticker.isNotEmpty && quantity > 0 && price > 0) {
      _investmentsModel.addInvestment(ticker, quantity, price);
      setState(() {});
      _tickerController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        'My Investments',
        style: TextStyle(
            fontWeight: FontWeight.bold, // Жирный
            fontSize: 25, // Размер текста
          ),
        )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: _tickerController,
              decoration: InputDecoration(
                labelText: 'Ticker',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 103, 184, 250), // Цвет обводки при фокусе  // Изменение жирности текста
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 103, 184, 250), // Цвет обводки при фокусе  // Изменение жирности текста
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontWeight: FontWeight.bold, // Изменение жирности текста
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 103, 184, 250), // Цвет обводки при фокусе  // Изменение жирности текста
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Цвет обводки при фокусе
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: _addInvestment,
              // ignore: sort_child_properties_last
              child: Text(
                'Add Investment',
                style: TextStyle(
                      fontWeight: FontWeight.bold, // Жирный
                      fontSize: 13, 
                  ),
                ),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 50),
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _investmentsModel.investments.length,
              itemBuilder: (context, index) {
                final investment = _investmentsModel.investments[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 13.0), // Добавление горизонтальных отступов
                  child: Card(
                    color: const Color.fromARGB(255, 211, 242, 255), // Изменение цвета фона карточки
                    child: ListTile(
                      title: Text(
                        investment.ticker,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Жирный
                          fontSize: 14, // Размер текста
                        ),
                      ),
                      subtitle: Text(
                        'Quantity: ${investment.quantity}, Average Price: ${investment.averagePrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Жирный
                          fontSize: 12,
                         ), // Размер текста
                        ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CryptoDetailScreen extends StatelessWidget {
  final CryptoCurrency crypto;

  CryptoDetailScreen({required this.crypto});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crypto.name),
      ),
      body: WebView(
        // ignore: prefer_interpolation_to_compose_strings
        initialUrl: 'data:text/html;charset=utf-8,' + Uri.encodeComponent('''
          <!-- TradingView Widget BEGIN -->
          <div class="tradingview-widget-container">
            <div class="tradingview-widget-container__widget"></div>
            <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
            <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-mini-symbol-overview.js" async>
            {
            "symbol": "BINANCE:${crypto.symbol}USDT",
            "width": "100%",
            "height": "100%",
            "locale": "en",
            "dateRange": "1M",
            "colorTheme": "light",
            "isTransparent": true,
            "autosize": true,
            "largeChartUrl": "",
            "chartOnly": false
          }
            </script>
          </div>
          <!-- TradingView Widget END -->
        '''),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Новости',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Жирный
            fontSize: 25, // Размер текста
          ),
        ),
      ),
      body: WebView(
        // ignore: prefer_interpolation_to_compose_strings
        initialUrl: 'data:text/html;charset=utf-8,' + Uri.encodeComponent('''
          <!-- TradingView Widget BEGIN -->
          <div class="tradingview-widget-container" style="width: 100%; height: 100vh;">
            <div class="tradingview-widget-container__widget"></div>
            <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
            {
              "feedMode": "all_symbols",
              "isTransparent": true,
              "displayMode": "adaptive",
              "width": "100%",
              "height": "100%",
              "colorTheme": "light",
              "locale": "en"
            }
            </script>
          </div>
          <!-- TradingView Widget END -->
        '''),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}



class ThemeModel with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Используйте ThemeMode.light или ThemeMode.dark по умолчанию, если хотите

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Жирный
            fontSize: 25, // Размер текста
            ),
        )
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Настройки темы приложения'),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 50),
                  ),
              onPressed: () {
                // Логика для переключения на светлую тему
                Provider.of<ThemeModel>(context, listen: false).setTheme(ThemeMode.light);
              },
              child: Text('Светлая тема'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color.fromRGBO(145, 209, 255, 1), // Цвет текста
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 50),
                  ),
              onPressed: () {
                // Логика для переключения на темную тему
                Provider.of<ThemeModel>(context, listen: false).setTheme(ThemeMode.dark);
              },
              child: Text('Темная тема'),
            ),
          ],
        ),
      ),
    );
  }
}