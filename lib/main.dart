import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

 class _MyAppState extends State<MyApp> {
  @override void initState() {
    // TODO: implement initState
    super.initState();
  }

Color temp = Colors.grey;

int counter = 26;

void _onPressedLike() {
  setState((){
    // temp == Colors.red?temp=Colors.grey:temp=Colors.red;
    if(temp == Colors.grey){
      temp = Colors.red;
      counter++;
    }else {
      temp = Colors.grey;
      counter--;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Общежития КубГАУ'),
          ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column( 
              children:[
                Container (
                  child: const Image(image: AssetImage('assets/imagelab.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(
                            'Общежитие №20', 
                            style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          Text(
                            'Краснодар, ул. Калинина, 13',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                      IconButton(
                        onPressed: _onPressedLike, 
                        icon: const Icon(Icons.favorite),
                        color: temp,
                      ),
                      Text(counter.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(onPressed: () {
                          const SizedBox(height: 12.0);
                          const AlertDialog(content: Text('F'), backgroundColor: Colors.amber,);
                        },
                        icon: const Icon(Icons.phone),
                        color: Colors.green,
                        ),
                        const Text('ПОЗВОНИТЬ', style: TextStyle(color: Colors.green),),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: (){
                            const AlertDialog(content: Text('В разработке'));
                          }, 
                          icon: const Icon(Icons.near_me),
                          color: Colors.green,
                          ),
                          const Text('МАРШРУТ', style: TextStyle(color: Colors.green),),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('В разработке'), backgroundColor: Colors.grey),
                            );
                          }, 
                          icon: const Icon(Icons.share),
                          color: Colors.green,
                        ),
                        const Text('ПОДЕЛИТЬСЯ', style: TextStyle(color: Colors.green),)
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  child: const Text('«Студенческий городок или так называемый кампус Кубанского ГАУ состоит'
                                'из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях'
                                'университета, при поселении между администрацией и студентами заключается'
                                'договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия'
                                'асоциальных явлений в молодежной среде. Условия проживания в общежитиях'
                                'университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и'
                                'наглядной агитации. С целью улучшения условий быта студентов активно работает'
                                'система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.».',
                  softWrap: true,
                  ),
                ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

