import 'package:flutter/material.dart';
import '../service/question_service.dart';
import '../model/question.dart';
import '../dialog/save_score_dialog.dart';

class TriviaScreen extends StatefulWidget {
  final String difficulty;

  const TriviaScreen({super.key, required this.difficulty});

  @override
  // ignore: library_private_types_in_public_api
  _TriviaScreenState createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  late Future<List<Question>> futureQuestions;
  int currentQuestionIndex = 0;
  int score = 0;

  int getPointsForCorrectAnswer() {
    switch (widget.difficulty) {
      case 'easy':
        return 10;
      case 'medium':
        return 20;
      case 'hard':
        return 30;
      default:
        return 10;
    }
  }

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions(difficulty: widget.difficulty);
  }

  void _checkAnswer(Question question, String selectedAnswer) {
    if (question.isCorrectAnswer(selectedAnswer)) {
      setState(() {
        score += getPointsForCorrectAnswer();
      });
      _showFeedbackDialog('✅ Correcto', '¡Bien hecho! 😄');
    } else {
      _showFeedbackDialog(
          '❌ Incorrecto', 'La respuesta correcta era: ${question.correctAnswer}');
    }
  }

  void _showFeedbackDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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
          title: const Text('🎉 Juego Terminado', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tu puntuación final es: $score puntos',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                mostrarDialogoGuardarPuntuacion(context, score, widget.difficulty);
              },
              child: const Text('Guardar puntuación'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/'); // Ir al Home
                },
                child: const Text('Atras'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  futureQuestions = fetchQuestions(difficulty: widget.difficulty);
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
        title: Text(' ${widget.difficulty.toUpperCase()}'),
        backgroundColor: _getDifficultyColor(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Question>>(
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Puntuación: $score puntos',
                        style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Pregunta ${currentQuestionIndex + 1}/10',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ...allAnswers.map((answer) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                            elevation: 5,
                          ),
                          onPressed: () => _checkAnswer(currentQuestion, answer),
                          child: Text(
                            answer,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No se encontraron preguntas.'));
            }
          },
        ),
      ),
    );
  }

  Color _getDifficultyColor() {
    switch (widget.difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
