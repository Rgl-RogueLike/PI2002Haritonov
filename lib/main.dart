import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Инкремент'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState((){
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Значение инкремента:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red), ),
                  child: Text('-', style: TextStyle(fontSize: 40),),
                ),
                ElevatedButton(
                  onPressed: _incrementCounter, 
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),),
                    child: Text('+', style: TextStyle(fontSize: 40),),
                  )
              ],
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: _resetCounter,
                  child: Text('Сбросить', style: TextStyle(fontSize: 20, color: Colors.grey),),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
