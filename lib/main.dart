import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главное окно')),
      body: Center(child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
        },
        child: const Text('Открыть второе окно')
      ))
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Второе окно')),
      body: Center(child: ElevatedButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: const Text('Back'),
      ),),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  )
  );
}