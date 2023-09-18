import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Theme.of(context).colorScheme.background));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Placeholder()
    );
  }
}