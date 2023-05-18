import 'package:flutter/material.dart';
import 'package:lab3/classes/Enums.dart';
import 'classes/Machine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Machine',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Coffee Machine'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Machine coffeeMachine = Machine(Resources(
    coffeeBeans: 1500,
    milk: 1500,
    water: 1500,
    cash: 0,
  ));

  int _selectedValue = 1;
  void _handleSelection(int? value) {
    if (value != null) {
      setState(() {
        _selectedValue = value;
      });
    }
  }

  void _handleButtonPress() {
    setState(() {
      switch (_selectedValue) {
        case 1:
          makeCoffeeWithMessages(context, CoffeeType.espresso);
          break;
        case 2:
          makeCoffeeWithMessages(context, CoffeeType.americano);
          break;
        case 3:
          makeCoffeeWithMessages(context, CoffeeType.cappuccino);
          break;
        case 4:
          makeCoffeeWithMessages(context, CoffeeType.latte);
          break;
      }
    });
  }

  void makeCoffeeWithMessages(
      BuildContext context, CoffeeType coffeeType) async {
    try {
      List<String> messages = await coffeeMachine.makeCoffeeByType(coffeeType);
      for (String message in messages) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(Duration(seconds: 2));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при приготовлении кофе: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  final TextEditingController _textController =
      TextEditingController(text: '0');
  final TextEditingController _textController1 =
      TextEditingController(text: '0');
  final TextEditingController _textController2 =
      TextEditingController(text: '0');
  final TextEditingController _textController3 =
      TextEditingController(text: '0');
  final TextEditingController _textController4 =
      TextEditingController(text: '0');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.coffee)),
            Tab(icon: Icon(Icons.local_shipping)),
          ],
        ),
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 260,
                    color: Color.fromARGB(255, 155, 211, 24),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beans: ${coffeeMachine.coffeeBeans}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Milk: ${coffeeMachine.milk}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Water: ${coffeeMachine.water}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Container(
                          color: Colors.lightGreen[100],
                          padding: EdgeInsets.all(20),
                          height: 133,
                          width: 370,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Text('Coffee Maker',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold)),
                              Padding(padding: EdgeInsets.only(top: 28)),
                              Text('Your Money: ${coffeeMachine.cash}',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 290,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              height: 150,
                              child: ListView(
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text('espresso'),
                                    value: 1,
                                    groupValue: _selectedValue,
                                    onChanged: _handleSelection,
                                  ),
                                  RadioListTile(
                                    title: Text('americano'),
                                    value: 2,
                                    groupValue: _selectedValue,
                                    onChanged: _handleSelection,
                                  ),
                                  RadioListTile(
                                    title: Text('cappuchino'),
                                    value: 3,
                                    groupValue: _selectedValue,
                                    onChanged: _handleSelection,
                                  ),
                                  RadioListTile(
                                    title: Text('latte'),
                                    value: 4,
                                    groupValue: _selectedValue,
                                    onChanged: _handleSelection,
                                  )
                                ],
                              ),
                            )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 50, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 128,
                                        74), // задаем фоновый цвет для контейнера
                                    borderRadius: BorderRadius.circular(
                                        8.0), // задаем скругление углов
                                  ),
                                  child: IconButton(
                                    onPressed: _handleButtonPress,
                                    icon: Icon(Icons.play_arrow),
                                    color: Colors.black, // задаем цвет иконки
                                  ),
                                )),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: TextField(
                                      controller: _textController,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 16.0),
                                      autofocus:
                                          false, // установите значение false
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: 'Put money here',
                                          labelStyle: TextStyle(fontSize: 18)),
                                    ))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 160, 236,
                                        38), // задаем фоновый цвет для контейнера
                                    borderRadius: BorderRadius.circular(
                                        8.0), // задаем скругление углов
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        double? value = double.tryParse(
                                            _textController.text)!;
                                        coffeeMachine.fillCash(value);
                                      });
                                    },
                                    icon: Icon(Icons.monetization_on),
                                    color: Colors.black, // задаем цвет иконки
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 30, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 14,
                                        235), // задаем фоновый цвет для контейнера
                                    borderRadius: BorderRadius.circular(
                                        8.0), // задаем скругление углов
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Ваши деньги возвращены'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      setState(() {
                                        coffeeMachine.returnAllCash();
                                      });
                                    },
                                    icon: Icon(Icons.money_off),
                                    color: Colors.black, // задаем цвет иконки
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300,
                    color: Color.fromARGB(255, 155, 211, 24),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.lightGreen[100],
                          padding: EdgeInsets.all(20),
                          height: 250,
                          width: 370,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Resources:',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold)),
                              Padding(padding: EdgeInsets.only(top: 28)),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Milk: ${coffeeMachine.milk}    ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Water: ${coffeeMachine.water}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Beans: ${coffeeMachine.coffeeBeans}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                        '     Cash: ${coffeeMachine.usercash.toInt()}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                controller: _textController1,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                                autofocus: false, // установите значение false
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Put milk',
                                    labelStyle: TextStyle(fontSize: 18)),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                controller: _textController2,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                                autofocus: false, // установите значение false
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Put water',
                                    labelStyle: TextStyle(fontSize: 18)),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                controller: _textController3,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                                autofocus: false, // установите значение false
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Put beans',
                                    labelStyle: TextStyle(fontSize: 18)),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                controller: _textController4,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16.0),
                                autofocus: false, // установите значение false
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Put cash',
                                    labelStyle: TextStyle(fontSize: 18)),
                              )),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(150, 0, 10, 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 8, 185,
                                        17), // задаем фоновый цвет для контейнера
                                    borderRadius: BorderRadius.circular(
                                        8.0), // задаем скругление углов
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        double? value1 = double.tryParse(
                                            _textController1.text)!;
                                        double? value2 = double.tryParse(
                                            _textController2.text)!;
                                        double? value3 = double.tryParse(
                                            _textController3.text)!;
                                        double? value4 = double.tryParse(
                                            _textController4.text)!;
                                        coffeeMachine.addAllRes(
                                            value1, value2, value3, value4);
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                    color: Colors.black, // задаем цвет иконки
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 233, 23,
                                        23), // задаем фоновый цвет для контейнера
                                    borderRadius: BorderRadius.circular(
                                        8.0), // задаем скругление углов
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        double? value1 = double.tryParse(
                                            _textController1.text)!;
                                        double? value2 = double.tryParse(
                                            _textController2.text)!;
                                        double? value3 = double.tryParse(
                                            _textController3.text)!;
                                        double? value4 = double.tryParse(
                                            _textController4.text)!;
                                        coffeeMachine.RemoveAllRes(
                                            value1, value2, value3, value4);
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                    color: Colors.black, // задаем цвет иконки
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
