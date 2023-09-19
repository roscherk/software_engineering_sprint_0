import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Theme.of(context).colorScheme.background));
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constrains) {
          const expressionsOnPage = 10;
          var notificationBarHeight = MediaQuery.of(context).viewPadding.top;
          var availableHeight = constrains.maxHeight -
              notificationBarHeight -
              MediaQuery.of(context).viewPadding.bottom;
          var buttonHeight = availableHeight / expressionsOnPage;
          var expressionListHeight =
              availableHeight * (expressionsOnPage - 1) / expressionsOnPage;
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
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            shape: const BeveledRectangleBorder(),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          child: Text('BACK',
                              style:
                                  Theme.of(context).textTheme.headlineSmall)),
                    ),
                  ),
                ),
                // Requests list
                SizedBox(
                  height: expressionListHeight,
                  child: _buildExpressionList(
                      _getHistory(), availableHeight / expressionsOnPage),
                )
              ],
            ),
          );
        }));
  }

  Future<List<List<String>>?> _getHistory() async {
    try {
      final result = http.post(Uri.parse(
          'http://${Calculator.serverIP}:${Calculator.serverPort}/history'));
      // TODO: отпарсить result (а лучше сразу получать его в JSON)
      return Future.value([
        ['request1', 'result1'],
        ['Long-long-long-long-long request', 'short res']
      ]);
    } catch (exception, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: exception.toString());
    }
    return null;
  }

  FutureBuilder<List<List<String>>?> _buildExpressionList(
      Future<List<List<String>>?> futureList, double listElementHeight) {
    return FutureBuilder(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var history = snapshot.data!;
            return ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                  history.length,
                  (index) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: SizedBox(
                          height: listElementHeight,
                          child: TextButton(
                            onLongPress: () {
                              Navigator.pop(context, history[index][0]);
                            },
                            onPressed: () {
                              Navigator.pop(context, history[index][1]);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${history[index][0]} = ${history[index][1]}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                      )),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
