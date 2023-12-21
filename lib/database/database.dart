import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../models/task_models.dart';

class TaskDatabase {
  static const _databaseName = 'tasks.db';
  static const _databaseVersion = 1;

  TaskDatabase._privateConstructor();
  static final TaskDatabase instance = TaskDatabase._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String pathToDatabase = path.join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      pathToDatabase,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        status TEXT
      )
    ''');
  }

  Future<void> addTask(Task task) async {
    final db = await instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await instance.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
