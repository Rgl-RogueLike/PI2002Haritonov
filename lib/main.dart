import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

  int _width = 0;
  int _height = 0;
  int _square = 0;

  @override
  Widget build(BuildContext context){
    
     return Container(
      padding: const EdgeInsets.all(10.0),
      child:
        Form(
          key: _formKey,
          child: 
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text ('Ширина (мм):'),
                    Expanded(
                      child: 
                        TextFormField( 
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value){
                            if (value!.isEmpty) return 'Задайте Ширину';
                              _width = int.parse(value);
                            }),
                      ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    const Text ('Высоту (мм):'),
                    Expanded(
                      child: 
                        TextFormField(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                          validator: (value){
                            if (value!.isEmpty) return 'Задайте Высоту';
                              _height = int.parse(value);
                            }),
                      ),
                  ],
                ),

                const SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        if(_height != 0 && _width != 0) _square = _width * _height;
                      });
                      String item = _square.toString();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(item), backgroundColor: Colors.green,),
                      );
                    }
                  },
                  child:
                    const Text('Посчитать', style: TextStyle(color: Colors.white)),
                ), 
                
                const SizedBox(height: 50.0),

                Column(
                  children: [
                    if(_square == 0)
                      const Text('задайте параметр', style: TextStyle(fontSize: 25.0),)
                    else
                     Text('S = $_width * $_height = $_square (см2)', style: const TextStyle(fontSize: 25.0))
                  ],
                )
                // Text(
                //   {if(_square == 0)
                //     'Задайте параметры'
                //   else  'S = $_width * $_height = ${_area} (см2)'},
                //   style: TextStyle(fontSize: 30.0),
                // ),
            ],
          ),
        ),
    );
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('Калькулятор площади')),
      body: const MyForm()
    )
  )
);

