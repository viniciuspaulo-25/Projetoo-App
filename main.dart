import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // Lista para armazenar as tarefas
  List<Map<String, dynamic>> _tasks = [];

  // Controlador para o campo de texto
  TextEditingController _taskController = TextEditingController();

  // Função para adicionar uma nova tarefa
  void _addTask() {
    String taskText = _taskController.text;
    if (taskText.isNotEmpty) {
      setState(() {
        _tasks.insert(0, {'task': taskText, 'completed': false});
      });
      _taskController.clear(); // Limpa o campo de texto
    }
  }

  // Função para mover a tarefa ao final/início da lista
  void _toggleTaskCompletion(int index) {
    setState(() {
      var task = _tasks[index];
      task['completed'] = !task['completed'];
      _tasks.removeAt(index); // Remove do índice atual
      if (task['completed']) {
        _tasks.add(task); // Coloca no final se estiver concluída
      } else {
        _tasks.insert(0, task); // Coloca no início se não estiver concluída
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para adicionar novas tarefas
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Digite uma tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      _tasks[index]['task'],
                      style: TextStyle(
                        decoration: _tasks[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    value: _tasks[index]['completed'],
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index);
                    },
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
