import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(244, 255, 255, 255),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            primary: const Color.fromARGB(255, 34, 34, 34),
            onPrimary: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/service': (context) => ServiceSearchScreen(),
        '/history': (context) => HistoryScreen(),
        '/buy': (context) => BuyScreen(),
        '/recommendation': (context) => RecommendationScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Центр Toyota'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Перейти к услугам'),
          onPressed: () => Navigator.pushNamed(context, '/service'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/service');
              break;
            case 2:
              Navigator.pushNamed(context, '/history');
              break;
            case 3:
              Navigator.pushNamed(context, '/buy');
              break;
            case 4:
              Navigator.pushNamed(context, '/recommendation');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: ''),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 52, 48, 48),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class ServiceSearchScreen extends StatefulWidget {
  @override
  _ServiceSearchScreenState createState() => _ServiceSearchScreenState();
}

class _ServiceSearchScreenState extends State<ServiceSearchScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _sendConsultationRequest() {
    _showSnackBar("Консультационный запрос отправлен. Номер телефона: ${_phoneController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сервисный Центр'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на ТО"),
              child: const Text('Техническое обслуживание'),
            ),
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на диагностику"),
              child: const Text('Диагностика'),
            ),
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на ремонт"),
              child: const Text('Ремонт'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Ваш номер телефона',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendConsultationRequest,
              child: const Text('Отправка заявки на консультацию'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> historyItems = ['Покупка 1', 'Покупка 2'];
  final TextEditingController _historyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(historyItems[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        historyItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _historyController,
              decoration: InputDecoration(
                labelText: 'Добавить элемент',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_historyController.text.isNotEmpty) {
                setState(() {
                  historyItems.add(_historyController.text);
                  _historyController.clear();
                });
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<String> buyItems = ['Товар 1', 'Товар 2'];
  final TextEditingController _buyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Покупка'),
      ),
      body: ListView.builder(
        itemCount: buyItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(buyItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  buyItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Добавить товар'),
                content: TextField(
                  controller: _buyController,
                  decoration: InputDecoration(
                    hintText: 'Название товара',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_buyController.text.isNotEmpty) {
                        setState(() {
                          buyItems.add(_buyController.text);
                          _buyController.clear();
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<String> recommendationItems = ['Рекомендация 1', 'Рекомендация 2'];
  final TextEditingController _recommendationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рекомендации'),
      ),
      body: ListView.separated(
        itemCount: recommendationItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendationItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  recommendationItems.removeAt(index);
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Добавить рекомендацию'),
                content: TextField(
                  controller: _recommendationController,
                  decoration: InputDecoration(
                    hintText: 'Название рекомендации',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_recommendationController.text.isNotEmpty) {
                        setState(() {
                          recommendationItems.add(_recommendationController.text);
                          _recommendationController.clear();
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
