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
              secondary: Colors.white70,
              onSecondary: Colors.black26,
              error: Colors.white38,
              onError: Colors.deepOrangeAccent,
              background: Colors.white,
              onBackground: Colors.white38,
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

  void _handleButtonTap(String buttonText,) {
    const List<String> operations = ['C', 'DEL', '±', '÷', '×', '-', '+', '='];
    bool endsWithOperator = currentExpression.isNotEmpty && operations.sublist(3).contains(currentExpression.substring(currentExpression.length - 1));
    if (operations.contains(buttonText)) {
      if (currentExpression.isEmpty) {
        return; // do not append anything
      } else if (buttonText == 'C') {
        setState(() {
          currentExpression = '';
        });
        return; // do not append anything
      } else if (buttonText == 'DEL') {
        if (currentExpression.length == 2 && currentExpression.startsWith('-')) {
          setState(() {
            currentExpression = '';
          });
        } else {
          setState(() {
            currentExpression =
                currentExpression.substring(0, currentExpression.length - 1);
          });
        }
        return; // do not append anything
      } else if (buttonText == '±') {
        String operators = r'[÷×\-+(]';
        int index = currentExpression.lastIndexOf(RegExp(operators));
        debugPrint(index.toString());
        if (index == -1) {
          // no operators in currentExpression, so it is just a number
          setState(() {
            currentExpression = '--$currentExpression';
          });
        } else if (currentExpression[index] == '+') {
          setState(() {
            currentExpression = currentExpression.replaceRange(index, index + 1, '-');
          });
        } else if (currentExpression[index] == '-') {
          if (index == 0 || RegExp(operators).hasMatch(currentExpression[index - 1])) {
            setState(() {
              currentExpression = currentExpression.replaceRange(index, index + 1, '');
            });
          } else {
            setState(() {
              currentExpression = currentExpression.replaceRange(index, index + 1, '+');
            });
          }
        } else {
          setState(() {
            currentExpression = currentExpression.replaceRange(index + 1, index + 1, '-');
          });
        }
        if (currentExpression.startsWith('-')) {
          setState(() {
            currentExpression = currentExpression.substring(1, currentExpression.length);
          });
        } else if (!endsWithOperator) {

        }
        return; // do not append anything
      } else if (buttonText == '=') {
        // String expression = currentExpression.replaceAll('÷', '/').replaceAll('×', '*');
        // TODO: добавить post-запрос на сторону сервиса
        // TODO: и вывести ответ на экран
        return; // do not append anything
      } else if (endsWithOperator) {
        setState(() {
          currentExpression = currentExpression.substring(0, currentExpression.length - 1);
        });
      }
    }
    setState(() {
      currentExpression += buttonText;
    });
  }

  void _delButton() {

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          var availableHeight = constrains.maxHeight - MediaQuery.of(context).viewPadding.top - MediaQuery.of(context).viewPadding.bottom;
          var textBoxSize = availableHeight / 3;
          var keyboardSize = availableHeight * 2 / 3;
          var buttonSize = Size(constrains.maxWidth / buttons.first.length, keyboardSize / buttons.length);
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
