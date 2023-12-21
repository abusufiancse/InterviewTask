import 'package:flutter/material.dart';
import 'package:interview_task/database/database.dart';
import 'package:interview_task/models/task_models.dart';
import 'package:sqflite/sqflite.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  Database? _database;

  List<Task> get tasks => _tasks;

  get completedTasks => null;

  Future<void> initializeDatabase() async {
    _database = await TaskDatabase.initDatabase();
    _tasks = await TaskDatabase.getAllTasks(_database!);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase.insertTask(_database!, task);
    _tasks = await TaskDatabase.getAllTasks(_database!);
    notifyListeners();
  }

  Future<Task> getTask(int id) async {
    return await TaskDatabase.getTaskById(_database!, id);
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase.updateTask(_database!, task);
    _tasks = await TaskDatabase.getAllTasks(_database!);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.deleteTask(_database!, id);
    _tasks = await TaskDatabase.getAllTasks(_database!);
    notifyListeners();
  }

  void toggleTaskCompletion(int i) {}
}
