import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX 03',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          color: Colors.blue,
          elevation: 0
        )
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
  
  String _expression = '';
  String _result = '0';
  bool _hasResult = false;

  void _onButtonPressed(String value) {
    setState(() {
      switch (value) {
        case 'AC':
          _expression = '';
          _result = '0';
          _hasResult = false;
          break;
        case 'C':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
            if (_expression.isEmpty) {
              _result = '0';
              _hasResult = false;
            } else {
              _calculateResult();
            }
          }
          break;
        case '=':
          _calculateResult();
          _hasResult = true;
          break;
        case '+':
        case '-':
        case '×':
        case '/':
          if (_hasResult) {
            _expression = _result + value;
            _hasResult = false;
          } else if (_expression.isNotEmpty && !_isOperator(_expression[_expression.length - 1])) {
            _expression += value;
          } else if (value == '-' && (_expression.isEmpty || _isOperator(_expression[_expression.length - 1]))) {
            // Allow negative numbers
            _expression += value;
          }
          break;
        default:
          if (_hasResult && !_isOperator(value)) {
            _expression = value;
            _hasResult = false;
          } else {
            _expression += value;
          }
          _calculateResult();
      }
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '/';
  }

  void _calculateResult() {
    if (_expression.isEmpty) {
      _result = '0';
      return;
    }

    try {
      // Replace × with * for calculation
      String expr = _expression.replaceAll('×', '*');
      
      // Evaluate the expression
      double result = _evaluateExpression(expr);
      
      // Format the result
      if (result == result.toInt()) {
        _result = result.toInt().toString();
      } else {
        _result = result.toString().replaceAll(RegExp(r'\.?0*$'), '');
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    // Remove spaces
    expression = expression.replaceAll(' ', '');
    
    // Handle empty expression
    if (expression.isEmpty) return 0;
    
    // Parse and evaluate the expression
    return _parseExpression(expression);
  }

  double _parseExpression(String expr) {
    List<String> tokens = _tokenize(expr);
    return _evaluateTokens(tokens);
  }

  List<String> _tokenize(String expr) {
    List<String> tokens = [];
    String currentNumber = '';
    
    for (int i = 0; i < expr.length; i++) {
      String char = expr[i];
      
      if (char == '+' || char == '*' || char == '/') {
        if (currentNumber.isNotEmpty) {
          tokens.add(currentNumber);
          currentNumber = '';
        }
        tokens.add(char);
      } else if (char == '-') {
        if (currentNumber.isNotEmpty) {
          tokens.add(currentNumber);
          currentNumber = '';
        }
        // Check if it's a negative sign or subtraction
        if (i == 0 || (i > 0 && (expr[i-1] == '+' || expr[i-1] == '-' || expr[i-1] == '*' || expr[i-1] == '/'))) {
          currentNumber = '-';
        } else {
          tokens.add('-');
        }
      } else {
        currentNumber += char;
      }
    }
    
    if (currentNumber.isNotEmpty) {
      tokens.add(currentNumber);
    }
    
    return tokens;
  }

  double _evaluateTokens(List<String> tokens) {
    if (tokens.isEmpty) return 0;
    if (tokens.length == 1) return double.parse(tokens[0]);
    
    // Handle multiplication and division first (higher precedence)
    for (int i = 1; i < tokens.length - 1; i += 2) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double result;
        
        if (tokens[i] == '*') {
          result = left * right;
        } else {
          if (right == 0) throw Exception('Division by zero');
          result = left / right;
        }
        
        tokens[i - 1] = result.toString();
        tokens.removeAt(i);
        tokens.removeAt(i);
        i -= 2;
      }
    }
    
    // Handle addition and subtraction (lower precedence)
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length - 1; i += 2) {
      double operand = double.parse(tokens[i + 1]);
      if (tokens[i] == '+') {
        result += operand;
      } else if (tokens[i] == '-') {
        result -= operand;
      }
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.end,
                    controller: TextEditingController(text: _expression.isEmpty ? '|' : _expression),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      disabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.end,
                    controller: TextEditingController(text: _result),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

                    decoration: InputDecoration(
                      disabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      ),
                    )
                  ),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(
              color: Colors.grey,
              child: GridButton(
              textStyle: TextStyle(

              ),
              borderColor: Colors.grey[300],
              borderWidth: 2,
              onPressed: (dynamic val) {
                _focusNode.requestFocus();
                _onButtonPressed(val);
              },
              items: [
                [
                  const GridButtonItem(title: "7",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "8",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "9",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "C",textStyle: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),color: Colors.blue),
                  GridButtonItem(title: "AC",textStyle: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),color: Colors.blue),
                ],
                [
                  const GridButtonItem(title: "4",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "5",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "6",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "+",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "-",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),

                ],
                [
                  const GridButtonItem(title: "1",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "2",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  const GridButtonItem(title: "3",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "×",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "/",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),

                ],
                [
                  GridButtonItem(title: "0",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: ".",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),

                  GridButtonItem(
                      title: "00",color: Colors.blue,textStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight:FontWeight.bold)),
                  GridButtonItem(title: "=", flex: 2,color: Colors.amber,textStyle: TextStyle(color: Colors.white,fontSize:18,fontWeight:FontWeight.bold,)),
                ],
              ],
            ),
            ))

          ],
        ),
      ),
    );
  }
}
