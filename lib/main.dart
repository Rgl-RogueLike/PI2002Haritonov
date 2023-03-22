import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      title: 'Список элементов',
      theme: ThemeData(
        primarySwatch: Colors.green,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Список элементов'),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Text('Строка $index');
            }
          ),
        ),
    );
  }
}

