import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX 01',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
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
  String simpletext = 'A  simple text';
  String hellotext = 'Hello World!';
  String title = '';

  @override
  void initState() {
    title = simpletext;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {  
                setState(() {
                  if (title == simpletext) {
                  title = hellotext;
                } else {
                  title = simpletext;
                }
                });
                print('Button pressed');
              },
              child: Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
