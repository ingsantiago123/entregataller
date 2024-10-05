import 'package:flutter/material.dart';
import 'dart:convert'; // Importa la librería para convertir JSON
import 'package:http/http.dart' as http;

class CharacterDetailPage extends StatefulWidget {
  final dynamic character; // Información del personaje

  const CharacterDetailPage({Key? key, required this.character}) : super(key: key); // Agregar const en el constructor

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  List<dynamic> episodes = []; // Lista de episodios en los que aparece el personaje

  @override
  void initState() {
    super.initState();
    fetchEpisodes(); // Cargar episodios al iniciar la pantalla
  }

  // Función para cargar los episodios de un personaje
  Future<void> fetchEpisodes() async {
    List<dynamic> episodeUrls = widget.character['episode']; // Lista de URLs de episodios
    List<dynamic> episodeData = [];

    for (String url in episodeUrls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        episodeData.add(json.decode(response.body)); // Guardar cada episodio
      }
    }

    setState(() {
      episodes = episodeData; // Guardamos los episodios obtenidos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.character['name'], // Nombre del personaje en la AppBar
          style: const TextStyle(
            fontFamily: 'RobotoMono', // Fuente llamativa
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: episodes.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white, // Indicador de carga blanco
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Espaciado
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Hero(
                        tag: widget.character['id'], // Hero animation
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundImage: NetworkImage(widget.character['image']),
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
                    ),
                    const SizedBox(height: 20.0), // Espacio entre la imagen y el texto
                    Text(
                      'Información del personaje',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent, // Verde neón
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Nombre: ${widget.character['name']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Especie: ${widget.character['species']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Estado: ${widget.character['status']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Episodios en los que aparece:',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent, // Verde neón
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    episodes.isEmpty
                        ? const Center(
                            child: Text(
                              'No hay episodios disponibles.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true, // Ajusta el tamaño al contenido
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: episodes.length,
                            itemBuilder: (context, index) {
                              final episode = episodes[index];
                              return Card(
                                color: Colors.black87,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    episode['name'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Episodio: ${episode['episode']}',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
