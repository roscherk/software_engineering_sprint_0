import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprint_0_calculator/calc_button.dart';
import 'package:sprint_0_calculator/history.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Colors.transparent));
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
          colorScheme: const ColorScheme.dark().copyWith(primary: Colors.white),
          textTheme: GoogleFonts.pressStart2pTextTheme().apply(
              bodyColor: Colors.white,
              displayColor: Colors.white)),
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

  @override
  Widget build(BuildContext context) {
    const List<List<String>> buttons = [
      ['C', '(', ')', '÷',],
      ['7', '8', '9', '×',],
      ['4', '5', '6', '-',],
      ['1', '2', '3', '+',],
      ['0', '.', '±', '=']
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          var notificationBarHeight = MediaQuery.of(context).viewPadding.top;
          var availableHeight = constrains.maxHeight - notificationBarHeight - MediaQuery.of(context).viewPadding.bottom;
          var textBoxSize = availableHeight / 3;
          var keyboardSize = availableHeight * 2 / 3;
          var buttonSize = Size(constrains.maxWidth / buttons.first.length, keyboardSize / buttons.length);
          return Padding(
            padding: EdgeInsets.only(top: notificationBarHeight),
            child: Column(
              children: [
                SizedBox(
                  width: constrains.maxWidth,
                  height: textBoxSize,
                  child: Stack(
                    children: [
                      // History button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: const BeveledRectangleBorder(),
                                side: const BorderSide(color: Colors.transparent),
                              ),
                              child: Text('HISTORY', style: Theme.of(context).textTheme.headlineSmall)),
                        ),
                      ),
                      // Textbox for expression
                      Padding(
                        padding: const EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SingleChildScrollView( // Textfield
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Text(
                                currentExpression,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          )
                      ),
                    ]
                  )
                ),
                // Keyboard
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
                                                onPressed: () => _handleButtonPress(buttons[row][index]),
                                                onLongPress: () => _handleButtonLongPress(buttons[row][index]))
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

  void _handleButtonPress(String buttonText,) {
    const List<String> operations = ['C', '±', '÷', '×', '-', '+', '='];
    bool endsWithOperator = currentExpression.isNotEmpty && operations.sublist(3).contains(currentExpression.substring(currentExpression.length - 1));
    if (operations.contains(buttonText)) {
      if (currentExpression.isEmpty) {
        return; // do not append anything
      } else if (buttonText == 'C') {
        _delButton();
        return; // do not append anything
      } else if (buttonText == '±') {
        _pmButton();
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

  void _handleButtonLongPress(String buttonText,) {
    if (buttonText == 'C') {
      setState(() {
        currentExpression = '';
      });
    }
    if (currentExpression == '42' && buttonText == '=') {
      setState(() {
        // Theme.of(context).textTheme = GoogleFonts.textMeOneTextTheme;
        currentExpression = 'heapof&gvozd design';
      });
    }
  }

  void _delButton() {
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
  }

  void _pmButton() {
    String operators = r'[÷×\-+(]';
    int index = currentExpression.lastIndexOf(RegExp(operators));
    if (index == -1) {
      // no operators in currentExpression, so it is just a number
      setState(() {
        currentExpression = '-$currentExpression';
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
  }
}
