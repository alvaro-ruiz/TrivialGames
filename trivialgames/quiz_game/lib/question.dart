import 'package:html/parser.dart' as html;

class Question {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: html.parse(json['question']).body?.text ?? 'Pregunta no disponible',
      correctAnswer: html.parse(json['correct_answer']).body?.text ?? 'Respuesta no disponible',
      incorrectAnswers: List<String>.from(
        (json['incorrect_answers'] as List).map(
          (answer) => html.parse(answer).body?.text ?? 'Respuesta incorrecta',
        ),
      ),
    );
  }

  // Mezclar respuestas (correctas e incorrectas)
  List<String> getAllAnswersShuffled() {
    final allAnswers = [...incorrectAnswers, correctAnswer];
    allAnswers.shuffle(); // Mezcla las respuestas
    return allAnswers;
  }

  // Verificar si una respuesta es correcta
  bool isCorrectAnswer(String answer) {
    return answer == correctAnswer;
  }
}
