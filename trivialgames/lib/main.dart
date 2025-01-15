import 'package:flutter/material.dart';
import 'trivial_service.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<Main> {
  final ApiService _apiService = ApiService();
  List<dynamic> _questions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _apiService.fetchQuestions(limit: 10, category: "general");
      if (mounted) {
        setState(() {
          _questions = questions;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener preguntas: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: _loading ? _buildLoadingIndicator() : _buildQuestionList(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildQuestionList() {
    return ListView.builder(
      itemCount: _questions.length,
      itemBuilder: (context, index) {
        final question = _questions[index];
        return _buildQuestionCard(question);
      },
    );
  }

  Widget _buildQuestionCard(dynamic question) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(question['question']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...question['incorrectAnswers'].map((answer) => Text('- $answer')),
            Text('- ${question['correctAnswer']}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
