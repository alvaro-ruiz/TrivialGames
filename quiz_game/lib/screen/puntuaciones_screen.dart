import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PuntuacionesScreen extends StatelessWidget {
  const PuntuacionesScreen({super.key});

  // Función para obtener los datos de Firestore
  Stream<QuerySnapshot> obtenerPuntuaciones() {
    return FirebaseFirestore.instance
        .collection('puntuaciones')
        .orderBy('puntuacion', descending: true) // Ordenar de mayor a menor
        .snapshots();
  }

  Color obtenerColorDificultad(String dificultad) {
    switch (dificultad) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 Puntuaciones Guardadas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: obtenerPuntuaciones(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('❌ Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sentiment_dissatisfied, size: 60, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'No hay puntuaciones guardadas.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              );
            }

            final puntuaciones = snapshot.data!.docs;

            return ListView.builder(
              itemCount: puntuaciones.length,
              itemBuilder: (context, index) {
                var doc = puntuaciones[index];
                String nombre = doc['nombre'];
                int puntuacion = doc['puntuacion'];
                String dificultad = doc['dificultad'];
                Color dificultadColor = obtenerColorDificultad(dificultad);

                return Card(
                  color: Colors.white.withOpacity(0.9),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: dificultadColor,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      nombre,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Puntuación: $puntuacion • Dificultad: ${dificultad.toUpperCase()}',
                      style: TextStyle(color: dificultadColor, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.star, color: Colors.amber, size: 30),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
