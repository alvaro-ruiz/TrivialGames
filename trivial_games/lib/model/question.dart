import 'package:html/parser.dart' as html; // Importa el paquete html

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
      question: _parseHtmlToString(json['question']), // Parsea la pregunta
      correctAnswer: _parseHtmlToString(json['correct_answer']), // Parsea la respuesta correcta
      incorrectAnswers: List<String>.from(
        (json['incorrect_answers'] as List).map(
          (answer) => _parseHtmlToString(answer), // Parsea cada respuesta incorrecta
        ),
      ),
    );
  }

  // Método para parsear HTML a texto plano
  static String _parseHtmlToString(String htmlString) {
    final document = html.parse(htmlString);
    return document.body?.text ?? 'Texto no disponible';
  }

  // Método para obtener todas las respuestas mezcladas
  List<String> getAllAnswersShuffled() {
    final allAnswers = List<String>.from(incorrectAnswers)..add(correctAnswer);
    allAnswers.shuffle();
    return allAnswers;
  }

  // Método para verificar si la respuesta es correcta
  bool isCorrectAnswer(String answer) {
    return answer == correctAnswer;
  }
}