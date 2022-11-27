import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //s
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List buttons = [
    'C',
    'DEL',
    '',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion,
                        style: const TextStyle(
                          fontSize: 20,
                        ))),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    //clear
                    return MyButton(
                      buttonColor: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                    );
                  } else if (index == 1) {
                    //delete
                    return MyButton(
                      buttonColor: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                    );
                  } else if (index == buttons.length - 1) {
                    //equal

                    return MyButton(
                      buttonColor: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  } else if (index == 2) {
                    //equal

                    return MyButton(
                      buttonColor: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttonTapped: () {},
                    );
                  } else {
                    return MyButton(
                      buttonColor: isOperator(buttons[index])
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQ = userQuestion;

    Parser p = Parser();
    Expression exp = p.parse(finalQ);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
