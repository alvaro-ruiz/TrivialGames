// question_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'question.dart';

Future<List<Question>> fetchQuestions({
  int amount = 50,
  String difficulty = 'medium',
  String type = 'multiple',
}) async {
  final String url = 'https://opentdb.com/api.php?amount=$amount&difficulty=$difficulty&type=$type';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<Question> questions = (data['results'] as List)
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();
    return questions;
  } else if (response.statusCode == 429) {
    throw Exception('Demasiadas solicitudes. Por favor, inténtalo más tarde.');
  } else {
    throw Exception('Error al cargar las preguntas: ${response.statusCode}');
  }
}
