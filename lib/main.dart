import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      home: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Center(
            child: Text(
              "Quizzler",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: const SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeperIconsList = [];

  keepScore(bool answer) {
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: "Quizzler",
          desc: "Quiz Ended.",
        ).show();
        quizBrain.reset();
        scoreKeeperIconsList = [];
      } else {
        if (quizBrain.checkAnswer(answer)) {
          scoreKeeperIconsList.add(
            Icon(
              Icons.check,
              color: Colors.teal[300],
            ),
          );
        } else {
          scoreKeeperIconsList.add(
            Icon(
              Icons.close,
              color: Colors.purple[300],
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.all(32.0),
            ),
            onPressed: () {
              keepScore(true);
            },
            child: const Text(
              "True",
              style: TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.all(32.0),
            ),
            onPressed: () {
              keepScore(false);
            },
            child: const Text(
              "False",
              style: TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: scoreKeeperIconsList,
          ),
        )
      ],
    );
  }
}
