import 'dart:async';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CrosswordGame extends StatefulWidget {
  @override
  _CrosswordGameState createState() => _CrosswordGameState();
}

class _CrosswordGameState extends State<CrosswordGame> {
  final List<String> solution = ["F", "L", "U", "T", "T", "E", "R"];
  List<String> userAnswers = List.filled(7, "");

  bool isTimerRunning = false;
  int elapsedTimeInSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crossword Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTimer(),
            SizedBox(height: 20),
            buildCrossword(),
            SizedBox(height: 20),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTimer() {
    return Text(
      'Time: $elapsedTimeInSeconds seconds',
      style: TextStyle(fontSize: 18),
    );
  }

  Widget buildCrossword() {
    return Column(
      children: List.generate(solution.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              userAnswers[index] = value.toUpperCase();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: solution[index],
            ),
          ),
        );
      }),
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: isTimerRunning ? null : startTimer,
      child: Text(isTimerRunning ? 'Solving...' : 'Start Solving'),
    );
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        elapsedTimeInSeconds += 1;
      });

      if (!userAnswers.contains("") && ListEquality().equals(userAnswers, solution)) {
        timer.cancel();
        showScoreDialog();
      }
    });
  }

  void showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You solved the crossword in $elapsedTimeInSeconds seconds.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      isTimerRunning = false;
      elapsedTimeInSeconds = 0;
      userAnswers = List.filled(7, "");
    });
  }
}
