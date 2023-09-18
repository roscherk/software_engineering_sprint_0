import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Theme.of(context).colorScheme.background));
    return Scaffold (
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top) + const EdgeInsets.all(8.0),
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
            child: Text('BACK', style: Theme.of(context).textTheme.headlineSmall)),
        ),
      )
      // Textbox for expression_list
              // Padding()
    );
  }
}