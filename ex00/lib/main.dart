import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX 00',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                'A  simple text',
                style: TextStyle(
                  fontWeight: FontWeight.bold,           
                  fontSize: 24,
                ),
                
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              print('Button pressed');
            }, child: Text('Click me'))
          ],
        ),
      )
    );
  }
}
