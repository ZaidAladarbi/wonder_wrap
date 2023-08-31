import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myLib/AuthProvider.dart';
import 'myLib/AppWidgets.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
  print('app running');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartingPage(),
    );
  }
}
