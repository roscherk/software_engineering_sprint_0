import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Color borderColor;
  final Color textColor;
  final String buttonText;
  const CalcButton({super.key, required this.borderColor, required this.textColor, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            shape: const ContinuousRectangleBorder(),
            side: BorderSide(color: borderColor)
          ),
          onPressed: () {
              debugPrint('$buttonText pressed');
          },
          child: Text(buttonText, style: TextStyle(color: textColor),)
    ));
  }

  void _processTap() {

  }
}