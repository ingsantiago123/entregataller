import 'package:flutter/material.dart';
import 'dart:convert'; // Importa la librería para convertir JSON
import 'package:http/http.dart' as http; // Importa el paquete http para hacer solicitudes HTTP
import 'character_detail_page.dart'; // Importa la nueva pantalla de detalles del personaje

void main() {
  runApp(const MyApp()); // Agregar const aquí ya que MyApp es un widget constante
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Const en el constructor mejora rendimiento

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF00FF00), // Verde neón
        scaffoldBackgroundColor: const Color(0xFF121212), // Fondo negro
        appBarTheme: const AppBarTheme(
          color: Color(0xFF00FF00), // Verde neón para la AppBar
        ),
        textTheme: const TextTheme(
        
          bodyMedium: TextStyle(color: Colors.white), // Corrección: bodyMedium en lugar de bodyText2
        ),
      ),
      home: const CharacterListPage(), // Agregar const aquí también
    );
  }
}

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key}) : super(key: key); // Const en el constructor

  @override
  _CharacterListPageState createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  List<dynamic> characters = []; // Lista vacía para almacenar los personajes de la API

  @override
  void initState() {
    super.initState();
    fetchCharacters(); // Llamamos a la función que obtiene los personajes al iniciar el widget
  }

  Future<void> fetchCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body); // Convertimos el JSON a un mapa
        characters = data['results']; // Guardamos la lista de personajes (data['results'])
      });
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personajes de Rick and Morty',
          style: TextStyle(
            fontFamily: 'RobotoMono', // Usamos una fuente llamativa
            fontSize: 24, // Tamaño de la fuente
            color: Colors.black, // Contraste de colores
          ),
        ),
        centerTitle: true, // Centra el título
      ),
      body: characters.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white, // Indicador de progreso blanco
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0), // Añadir const aquí
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Mostramos 2 personajes por fila
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(character: character),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                    ),
                    color: const Color(0xFF00FF00), // Color de la tarjeta verde neón
                    elevation: 5, // Sombra sutil
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: character['id'], // Hero animation
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(character['image']),
                            backgroundColor: Colors.black,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0), // Añadir const aquí
                        Text(
                          character['name'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5.0), // Añadir const aquí
                        Text(
                          character['species'],
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'RobotoMono',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
