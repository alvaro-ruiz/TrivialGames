class Question {
  final String id;
  final String category;
  final String format;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const Question({
    required this.id,
    required this.category,
    required this.format,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  /// Constructor para crear un objeto `Question` desde un JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    try {
      return Question(
        id: json['id'] ?? '',
        category: json['category'] ?? '',
        format: json['format'] ?? '',
        question: json['question'] ?? '',
        correctAnswer: json['correctAnswer'] ?? '',
        incorrectAnswers: List<String>.from(json['incorrectAnswers'] ?? []),
      );
    } catch (e) {
      throw Exception('Error al parsear Question: $e');
    }
  }

  /// Método para convertir un objeto `Question` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'format': format,
      'question': question,
      'correctAnswer': correctAnswer,
      'incorrectAnswers': incorrectAnswers,
    };
  }
}
