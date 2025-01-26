import 'package:flutter/material.dart';
import 'question_service.dart';
import 'question.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  _TriviaScreenState createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  late Future<List<Question>> futureQuestions;
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions();
  }

  void _checkAnswer(Question question, String selectedAnswer) {
    if (question.isCorrectAnswer(selectedAnswer)) {
      setState(() {
        score++;
      });
      _showFeedbackDialog('Correcto', '¡Bien hecho! 😄');
    } else {
      _showFeedbackDialog('Incorrecto', 'La respuesta correcta era: ${question.correctAnswer}');
    }
  }

  void _showFeedbackDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _goToNextQuestion();
              },
              child: const Text('Siguiente'),
            ),
          ],
        );
      },
    );
  }

  void _goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < 9) {
        currentQuestionIndex++;
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Juego Terminado'),
          content: Text('Tu puntuación final es: $score/10'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  futureQuestions = fetchQuestions();
                });
              },
              child: const Text('Reintentar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia App'),
      ),
      body: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final questions = snapshot.data!;
            final currentQuestion = questions[currentQuestionIndex];
            final allAnswers = currentQuestion.getAllAnswersShuffled();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pregunta ${currentQuestionIndex + 1}/10',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...allAnswers.map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _checkAnswer(currentQuestion, answer),
                        child: Text(answer),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron preguntas.'));
          }
        },
      ),
    );
  }
}
