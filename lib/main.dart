import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/arquivo.json');
    final data = json.decode(response);
    setState(() {
      movies = data;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 205, 203, 203), 
    appBar: AppBar(
      title: const Text('Filmes'),
      backgroundColor: const Color.fromARGB(255, 183, 181, 187), 
),
    body: movies.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['nome'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text("Descrição: ${movie['descricao']}"),
                      Text("Ano de lançamento: ${movie['ano_lancamento']}"),
                      Text("Duração: ${movie['tempo_duracao']}"),
                      Text("Classificação: ${movie['classificacao_indicativa']} anos"),
                      Text("Diretores: ${movie['diretores'].join(', ')}"),
                      Text("Atores: ${movie['atores'].join(', ')}"),
                    ],
                  ),
                ),
              );
            },
          ),
  );
}
}
