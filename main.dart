import 'package:flutter/material.dart';
import 'crossword_game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crossword Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CrosswordGame(),
    );
  }
}
