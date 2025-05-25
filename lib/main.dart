import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// mudei o MyApp em StatefulWidget para controlar o estado da lista
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contato> contatos = [
    Contato('Guilherme Bussolan', 'guilhermebussolan@gmail.com', true),
    Contato('Gustavo Bussolan', 'gustavobussolan@gmail.com', false),
    Contato('Rosangela Bussolan', 'rosangelabussolan@gmail.com', false),
    Contato('Vanessa Cabral', 'vanessacabral@gmail.com', false),
  ];

  @override
  Widget build(BuildContext context) {
    const title = 'Lista de Contato';

    int totalFavoritos = contatos.where((c) => c.favorito).length;

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Favoritos: $totalFavoritos',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        contatos[index].nomeCompleto[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(contatos[index].nomeCompleto),
                    subtitle: Text(contatos[index].email),
                    trailing: IconButton(
                      icon: Icon(
                        contatos[index].favorito
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            contatos[index].favorito ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          contatos[index].favorito =
                              !contatos[index].favorito;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Contato {
  String nomeCompleto;
  String email;
  bool favorito;

  Contato(this.nomeCompleto, this.email, this.favorito);
}
