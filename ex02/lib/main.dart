import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX 02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        appBarTheme: AppBarTheme(foregroundColor: Colors.white, color: Colors.blue, elevation: 0),
      ),
      home: const MyHomePage(title: 'Calculator'),
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
  final _focusNode = FocusNode(canRequestFocus: false, skipTraversal: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TextField(
                      readOnly: true,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      controller: TextEditingController(text: '0'),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      controller: TextEditingController(text: '0'),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey,
                child: GridButton(
                  textStyle: TextStyle(),
                  borderColor: Colors.grey[300],
                  borderWidth: 2,
                  onPressed: (dynamic val) {
                    _focusNode.requestFocus();
                    print(val);
                  },
                  items: [
                    [
                      const GridButtonItem(
                        title: "7",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "8",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "9",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "C",
                        textStyle: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                        color: Colors.blue,
                      ),
                      GridButtonItem(
                        title: "AC",
                        textStyle: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                        color: Colors.blue,
                      ),
                    ],
                    [
                      const GridButtonItem(
                        title: "4",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "5",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "6",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "+",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "-",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                    [
                      const GridButtonItem(
                        title: "1",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "2",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const GridButtonItem(
                        title: "3",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "×",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "/",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                    [
                      GridButtonItem(
                        title: "0",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: ".",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      GridButtonItem(
                        title: "00",
                        color: Colors.blue,
                        textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GridButtonItem(
                        title: "=",
                        flex: 2,
                        color: Colors.amber,
                        textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
