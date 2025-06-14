import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> _todos = [];
  late Database _database;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isCompleted INTEGER)',
        );
      },
    );

    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<Map<String, dynamic>> maps = await _database.query('todos');
    setState(() {
      _todos = List.generate(maps.length, (i) {
        return TodoItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          isCompleted: maps[i]['isCompleted'] == 1,
        );
      });
    });
  }

  Future<void> _addTodo(String title) async {
    await _database.insert('todos', {
      'title': title,
      'isCompleted': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    _loadTodos();
  }

  Future<void> _toggleTodo(int id, bool isCompleted) async {
    await _database.update(
      'todos',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    _loadTodos();
  }

  Future<void> _deleteTodo(int id) async {
    await _database.delete('todos', where: 'id = ?', whereArgs: [id]);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: 'New task',
                          labelStyle: TextStyle(color: Colors.blue.shade700),
                          hintText: 'What needs to be done?',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade400],
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            _addTodo(_textController.text);
                            _textController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _todos.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Colors.blue.shade200,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tasks yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          Text(
                            'Add your first task above',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return Dismissible(
                          key: Key(todo.id.toString()),
                          background: Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) => _deleteTodo(todo.id),
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: todo.isCompleted,
                                onChanged:
                                    (value) => _toggleTodo(todo.id, value!),
                                activeColor: Colors.blue.shade700,
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration:
                                      todo.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  color:
                                      todo.isCompleted
                                          ? Colors.grey.shade600
                                          : Colors.blue.shade800,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade400,
                                ),
                                onPressed: () => _deleteTodo(todo.id),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _database.close();
    super.dispose();
  }
}

class TodoItem {
  final int id;
  final String title;
  final bool isCompleted;

  TodoItem({required this.id, required this.title, required this.isCompleted});
}
