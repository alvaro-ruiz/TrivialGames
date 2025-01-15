import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.quiz-contest.xyz";
  final String apiKey = r"$2b$12$Id2JBbP4RuNsFs91MWdANeKNY8CY10r56t3phfZTVSAivqjn2V8gS";

  // Método para obtener preguntas
  Future<List<dynamic>> fetchQuestions({int limit = 10, String category = "general"}) async {
    try {
      // Construcción de la URL
      final uri = Uri.parse('$baseUrl/questions?limit=$limit&category=$category');

      // Realizar la solicitud
      final response = await http.get(
        uri,
        headers: {"Authorization": apiKey},
      );

      // Comprobar el estado de la respuesta
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['questions'] ?? [];
      } else {
        // Manejo de errores HTTP
        throw Exception('Error HTTP: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      // Manejo de excepciones
      throw Exception('Error al obtener preguntas: $error');
    }
  }
}

