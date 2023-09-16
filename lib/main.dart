import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprint_0_calculator/calc_button.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.black26,
              onSecondary: Colors.white70,
              error: Colors.black12,
              onError: Colors.deepOrangeAccent,
              background: Colors.white38,
              onBackground: Colors.white,
              surface: Colors.white60,
              onSurface: Colors.white),
          primaryColor: Colors.black,
          textTheme: GoogleFonts.pressStart2pTextTheme()
          ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final String currentExpression = '0';
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      'C', 'DEL', '±', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '(', ')', '='
    ];
    debugPrint('viewPadding: ${MediaQuery.of(context).viewPadding.top}');
    debugPrint('viewInsets: ${MediaQuery.of(context).viewInsets.top}');
    // var style = ElevatedButton.styleFrom(
    //   shape: const CircleBorder(),
    //   backgroundColor: Colors.transparent,
    //   textStyle: const TextStyle(fontSize: 60),
    // );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).viewPadding.top + 5, 8, 0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(currentExpression, style: TextStyle(color: Colors.white),),
                )
              )
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return CalcButton(
                      borderColor: Colors.white,
                      textColor: Colors.white,
                      buttonText: buttons[index]);
                }),
          ),
        ],
      ),
    );
  }
}
