// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void mostrarDialogoGuardarPuntuacion(BuildContext context, int puntuacion, String dificultad) {
  final TextEditingController nombreController = TextEditingController();
  bool botonActivo = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text(
              '🏆 Guardar Puntuación',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Puntuación: $puntuacion puntos',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nombreController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Introduce tu nombre',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    setState(() {
                      botonActivo = value.trim().isNotEmpty;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/'); // Ir al Home
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: botonActivo
                    ? () async {
                        String nombre = nombreController.text.trim();
                        if (nombre.isEmpty) return;

                        try {
                          await FirebaseFirestore.instance.collection('puntuaciones').add({
                            'nombre': nombre,
                            'puntuacion': puntuacion,
                            'dificultad': dificultad,
                            'fecha': DateTime.now(),
                          });

                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ Puntuación guardada correctamente'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pushReplacementNamed(context, '/'); // Redirigir al Home
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('❌ Error al guardar la puntuación: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey,
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );
}
