import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Afazeres'),
        ),
        body: Container(
          color: Color.fromARGB(255, 54, 86, 100), // Cor de fundo azul claro
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: Color.fromARGB(255, 71, 112,
                              129), // Cor de fundo branco para os itens da lista
                          child: CheckboxListTile(
                            title: Text(
                              _tarefas[index].descricao,
                              style: TextStyle(
                                  color: Colors.white), // Cor do texto branco
                            ),
                            value: _tarefas[index].status,
                            onChanged: (novoValor) {
                              setState(() {
                                _tarefas[index].status = novoValor ?? false;
                                if (_tarefas[index].status) {
                                  _removerTarefa(index);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: 8), // Espaçamento entre os itens da lista
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controlador,
                        decoration: InputDecoration(
                          hintText: 'Descrição',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white, // Cor de fundo branco
                        ),
                        onSubmitted: (text) {
                          _adicionarTarefa();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _adicionarTarefa,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(200, 60), // Cor do texto do botão
                      ),
                      child: const Text('Adicionar Tarefa'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _adicionarTarefa() {
    if (_controlador.text.isEmpty) {
      return;
    }
    setState(() {
      _tarefas.add(
        Tarefa(
          descricao: _controlador.text,
          status: false,
        ),
      );
      _controlador.clear();
    });
  }
}

class Tarefa {
  final String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
