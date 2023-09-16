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
      theme: ThemeData(  // это бесполезная штука, которая нигде не используется
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
          textTheme: GoogleFonts.pressStart2pTextTheme()),
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
  String currentExpression = '';

  void _handleButtonTap(String buttonText) {
    const List<String> operations = ['C', 'DEL', '±', '÷', '×', '-', '+', '='];
    // String lastChar = currentExpression.substring(0, currentExpression.length - 1);
    if (operations.contains(buttonText)) {
      if (buttonText == 'C') {
        setState(() {
          currentExpression = '';
        });
        return;
      } else if (buttonText == 'DEL') {
        setState(() {
          currentExpression = currentExpression.substring(0, currentExpression.length - 1);
        });
        return;
      } else if (buttonText == '±') {
        //TODO
        return;
      } else if (buttonText == '=') {
        //TODO
        return;
      } else if (operations.contains(currentExpression.substring(currentExpression.length - 1))) {
        setState(() {
          currentExpression = currentExpression.substring(0, currentExpression.length - 1) + buttonText;
        });
        return;
      }
    }
    setState(() {
      currentExpression += buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<List<String>> buttons = [
      ['C', 'DEL', '±', '÷',],
      ['7', '8', '9', '×',],
      ['4', '5', '6', '-',],
      ['1', '2', '3', '+',],
      ['0', '(', ')', '=']
    ];
    // debugPrint('viewPadding.top: ${MediaQuery.of(context).viewPadding.top}');
    // debugPrint('viewInsets.bottom: ${MediaQuery.of(context).padding.bottom}');
    // var style = ElevatedButton.styleFrom(
    //   shape: const CircleBorder(),
    //   backgroundColor: Colors.transparent,
    //   textStyle: const TextStyle(fontSize: 60),
    // );
    return Scaffold(
      // backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          var availableHeight = constrains.maxHeight - MediaQuery.of(context).viewPadding.top - MediaQuery.of(context).viewPadding.bottom;
          var textBoxSize = availableHeight / 3;
          var keyboardSize = 2 * availableHeight / 3;
          var buttonSize = Size(constrains.maxWidth / buttons.first.length, keyboardSize / buttons.length);
          // debugPrint(availableHeight.toString());
          // debugPrint(buttonSize.toString());
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Column(
              children: [
                SizedBox(
                  width: constrains.maxWidth,
                  height: textBoxSize,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            currentExpression,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        )
                    )
                ),
                SizedBox(
                    width: constrains.maxWidth,
                    height: keyboardSize,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Table(
                        children: List<TableRow>.generate(
                            buttons.length,
                                (row) =>
                                TableRow(
                                    children: List<CalcButton>.generate(
                                        buttons.first.length,
                                            (index) =>
                                            CalcButton(
                                                buttonText: buttons[row][index],
                                                size: buttonSize,
                                                onPressed: () => _handleButtonTap(buttons[row][index]))
                                    )
                                )
                        ),
                      ),
                    )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
