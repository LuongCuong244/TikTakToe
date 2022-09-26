// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.controller.dart';
import 'package:tiktaktoe/changenotifiers/game.dimensions.dart';
import 'package:tiktaktoe/screens/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GameController()),
    ChangeNotifierProvider(create: (context) => GameDimensions(context)),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTakToe',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}
