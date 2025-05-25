import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = contatos.removeAt(oldIndex);
                    contatos.insert(newIndex, item);
                  });
                },
                children: [
                  for (int index = 0; index < contatos.length; index++)
                    ListTile(
                      key: ValueKey(contatos[index].email),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://uploads.oparana.com.br/2025/01/BJiaxSsg-Imagem-do-WhatsApp-de-2025-01-31-as-12.23.18_4103b59e.webp',
                        ),
                      ),
                      title: Text(contatos[index].nomeCompleto),
                      subtitle: Text(contatos[index].email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              contatos[index].favorito
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: contatos[index].favorito
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                contatos[index].favorito =
                                    !contatos[index].favorito;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                contatos.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                ],
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
