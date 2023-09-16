import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String buttonText;
  final Size size;
  final onPressed;
  final Color borderColor;
  final Color textColor;

  const CalcButton(
      {super.key,
        required this.buttonText,
        required this.size,
        required this.onPressed,
        this.borderColor = Colors.white,
        this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    shape: const ContinuousRectangleBorder(),
                    side: BorderSide(color: borderColor)),
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                )
            ),
          )
      ),
    );
  }
}
