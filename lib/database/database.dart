import 'package:interview_task/models/task_models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTask(Database database, Task task) async {
    await database.insert('tasks', task.toMap());
  }

  static Future<List<Task>> getAllTasks(Database database) async {
    final List<Map<String, dynamic>> tasks = await database.query('tasks');
    return List.generate(tasks.length, (i) {
      return Task.fromMap(tasks[i]);
    });
  }

  static Future<Task> getTaskById(Database database, int id) async {
    final List<Map<String, dynamic>> tasks =
        await database.query('tasks', where: 'id = ?', whereArgs: [id]);
    return Task.fromMap(tasks.first);
  }

  static Future<void> updateTask(Database database, Task task) async {
    await database
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<void> deleteTask(Database database, int id) async {
    await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
