import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Theme.of(context).colorScheme.background));
    var history = _getHistory();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constrains) {
          const expressionsOnPage = 8;
          var notificationBarHeight = MediaQuery.of(context).viewPadding.top;
          var availableHeight = constrains.maxHeight -
              notificationBarHeight -
              MediaQuery.of(context).viewPadding.bottom;
          var buttonHeight = availableHeight / 10;
          var expressionListHeight = availableHeight * 9 / 10;
          return Padding(
            padding: EdgeInsets.only(top: notificationBarHeight),
            child: Column(
              children: [
                // Back button
                SizedBox(
                  height: buttonHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, '');
                          },
                          style: TextButton.styleFrom(
                            shape: const BeveledRectangleBorder(),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          child: Text('BACK',
                              style: Theme.of(context).textTheme.headlineSmall)),
                    ),
                  ),
                ),
                // Requests list
                SizedBox(
                  height: expressionListHeight,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                        history.length,
                        (index) => SizedBox(
                            height: availableHeight / expressionsOnPage,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, history[index][1]);
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                child: Text(
                                  '${history[index][0]} = ${history[index][1]}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
          );
        })
    );
  }

  List<List<String>> _getHistory() {
    // TODO: сделать запрос к серверу и получить список с историей выражений
    // for lulz and testing
    return [
      ['2 + 2', '4'],
      ['2 + 2 * 2', '6'],
      ['request', 'result'],
      ['request', 'result'],
      ['Very-very-very-very-very-very-very request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
      ['request', 'result'],
    ];
  }
}
