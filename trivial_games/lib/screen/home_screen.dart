import 'package:flutter/material.dart';
import '/screen/puntuaciones_screen.dart';
import 'trivial_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Trivial App',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Botón para seleccionar dificultad (Fácil)
              ElevatedButton(
                onPressed: () => _selectDifficulty(context, 'easy'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Fácil',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Botón para seleccionar dificultad (Medio)
              ElevatedButton(
                onPressed: () => _selectDifficulty(context, 'medium'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Medio',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Botón para seleccionar dificultad (Difícil)
              ElevatedButton(
                onPressed: () => _selectDifficulty(context, 'hard'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Difícil',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Botón para navegar a la pantalla de puntuaciones
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PuntuacionesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: const Color.fromARGB(255, 89, 54, 244),
                ),
                child: const Text(
                  'Puntuaciones',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para navegar a TriviaScreen con la dificultad seleccionada
  void _selectDifficulty(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TriviaScreen(difficulty: difficulty),
      ),
    );
  }
}
