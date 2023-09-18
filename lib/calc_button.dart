import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String buttonText;
  final Size size;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final Color borderColor;
  final Color textColor;

  const CalcButton(
      {super.key,
        required this.buttonText,
        required this.size,
        required this.onPressed,
        this.onLongPress,
        this.borderColor = Colors.transparent,
        this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(color: textColor);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: const BeveledRectangleBorder(),
                  side: BorderSide(color: borderColor)),
              onPressed: onPressed,
              onLongPress: onLongPress,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  buttonText,
                  style: textStyle,
                ),
              )
          )
      ),
    );
  }
}
