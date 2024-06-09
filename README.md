![Logo]([https://dev-to-uploads.s3.amazonaws.com/uploads/articles/th5xamgrr6se0x5ro4g6.png](https://drive.google.com/file/d/1pXk77trRyFCfNfcUkyiQbPZKgfKC3mzM/view?usp=sharing))
### Документация

#### Общий обзор
Этот Flutter проект представляет собой мобильное приложение, которое включает в себя различные экраны, такие как главная страница, экран криптовалют, экран новостей и экран настроек. Приложение поддерживает темы (светлую и темную) и использует различные пакеты для реализации функциональности, включая кэширование изображений и отображение веб-контента.

#### Основные компоненты

1. **Файл `main.dart`**: Основной файл приложения, который инициализирует и запускает приложение.
2. **Классы экранов**: Классы, представляющие различные экраны приложения.
3. **Пакеты**: Используемые сторонние пакеты, такие как `provider`, `webview_flutter`, `path_provider`, и `flutter_cache_manager`.

---

### Подробное описание кода

#### Импортируемые пакеты
```dart
import 'package:flutter/material.dart';
import 'crypto_parse_top.dart';
import 'crypto_bag.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
```
Эти пакеты предоставляют функциональность для работы с виджетами, веб-просмотром, файловой системой и управлением состоянием.

#### Функция main
```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}
```
Инициализирует приложение и предоставляет `ThemeModel` для управления темами через `ChangeNotifierProvider`.

#### Класс MyApp
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: theme.themeMode,
          home: HomeScreen(),
        );
      },
    );
  }
}
```
Основной класс приложения, который использует `Consumer` для получения текущей темы из `ThemeModel` и устанавливает её.

#### Функция downloadAndSaveGif
```dart
Future<File> downloadAndSaveGif(String url, String fileName) async {
  final cacheManager = DefaultCacheManager();
  final file = await cacheManager.getSingleFile(url);
  final dir = await getApplicationDocumentsDirectory();
  final savedFile = File('${dir.path}/$fileName');
  await file.copy(savedFile.path);
  return savedFile;
}
```
Загружает GIF-файл из интернета, сохраняет его в локальное хранилище и возвращает файл.

#### Класс HomeScreen
```dart
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
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                'Криптовалюты',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                  child: Text(
                    'Новости',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                    backgroundColor: Color.fromRGBO(145, 209, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(170, 170),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'Настройки',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                    backgroundColor: Color.fromRGBO(145, 209, 255, 1),
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
```
Главный экран приложения с заголовком, который включает в себя изображение GIF и название приложения. В теле экрана расположены кнопки для навигации к экранам криптовалют, новостей и настроек.

#### Класс CryptoScreen
```dart
class CryptoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Криптовалюты',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                'Топ криптовалют',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                backgroundColor: Color.fromRGBO(145, 209, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(350, 170),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text(
                'Мои инвестиции',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyInvestmentsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color.fromRGBO(145, 209, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(350, 170),
              ),
            ),
            SizedBox(height: 350),
          ],
        ),
      ),
    );
  }
}
```
Экран криптовалют с кнопками для перехода на экран топа криптовалют и экран моих инвестиций.

#### Класс TopCryptosScreen
```dart
class TopCryptosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Топ криптовалют',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Здесь будет список топовых криптовалют',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
```
Экран, отображающий топовые криптовалюты. На данный момент он содержит заглушку с текстом.

#### Класс MyInvestmentsScreen
```dart
class MyInvestmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои инвестиции',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Здесь будет информация о ваших инвестициях',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
```
Экран, отображающий информацию о ваших инвестициях. На данный момент он также содержит заглушку с текстом.

#### Класс NewsScreen
```dart
class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Новости',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Здесь будут отображаться последние новости',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
```
Экран новостей, который будет отображать последние новости. На данный момент также содержит заглушку с текстом.

#### Класс SettingsScreen
```dart
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Здесь будут настройки приложения',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
```
Экран настроек, который будет содержать настройки приложения. На данный момент содержит заглушку с текстом.

#### Функция для скачивания и сохранения GIF-файлов
```dart
Future<void> downloadAndSaveGif(String url, String fileName) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.gif';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('GIF сохранен по пути: $filePath');
    } else {
      print('Ошибка при загрузке GIF: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка: $e');
  }
}
```
Эта функция загружает GIF-файл по указанному URL и сохраняет его в локальной директории приложения. Она использует пакет `http` для выполнения HTTP-запроса и пакет `path_provider` для получения пути к директории документов.


#### Класс InvestmentsModel

Этот класс представляет модель данных для управления инвестициями пользователя. Он содержит список инвестиций и методы для добавления, загрузки и сохранения инвестиций.

```dart
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
```

##### Методы класса InvestmentsModel

- **addInvestment**: Этот метод добавляет новую инвестицию или обновляет существующую. Если инвестиция с таким же тикером уже существует, она обновляется с учетом новой средней цены и количества.
- **loadInvestments**: Этот метод загружает инвестиции из локального хранилища (SharedPreferences).
- **saveInvestments**: Этот метод сохраняет текущие инвестиции в локальное хранилище (SharedPreferences).

#### Класс Investment

Этот класс представляет собой модель данных для отдельной инвестиции.

```dart
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
```

##### Поля класса Investment

- **ticker**: Тикер (символ) криптовалюты.
- **quantity**: Количество купленных единиц криптовалюты.
- **averagePrice**: Средняя цена покупки.

##### Методы класса Investment

- **toJson**: Этот метод преобразует объект Investment в формат JSON.
- **fromJson**: Этот фабричный метод создает объект Investment из JSON.

#### Класс CryptoCurrency

Этот класс представляет модель данных для криптовалюты. Он включает поля для имени, символа, текущей цены и URL изображения криптовалюты.

```dart
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
```

##### Поля класса CryptoCurrency

- **name**: Имя криптовалюты.
- **symbol**: Символ (тикер) криптовалюты.
- **currentPrice**: Текущая цена криптовалюты.
- **imageUrl**: URL изображения криптовалюты.

##### Методы класса CryptoCurrency

- **fromJson**: Этот фабричный метод создает объект CryptoCurrency из JSON.

#### Функция fetchTopCryptos

Эта функция отвечает за получение данных о топовых криптовалютах с использованием API CoinGecko.

```dart
Future<List<CryptoCurrency>> fetchTopCryptos() async {
  final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1'));

  if (response.statusCode == 200) {
    List<dynamic> cryptosJson = json.decode(response.body);
    return cryptosJson.map((json) => CryptoCurrency.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load top cryptos');
  }
}
```

##### Описание функции fetchTopCryptos

- **Запрос к API**: Функция отправляет GET запрос к API CoinGecko для получения данных о топовых криптовалютах.
- **Обработка ответа**: Если статус ответа 200 (успешно), функция декодирует JSON ответ и преобразует его в список объектов CryptoCurrency.
- **Обработка ошибок**: Если статус ответа не 200, функция выбрасывает исключение с сообщением об ошибке.

