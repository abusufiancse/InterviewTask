import 'package:flutter/material.dart';
import 'package:interview_task/database/database.dart';
import '../models/task_models.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> initializeDatabase() async {
    await TaskDatabase.instance.database;
    await _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    _tasks = await TaskDatabase.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase.instance.addTask(task);
    await _fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase.instance.updateTask(task);
    await _fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.instance.deleteTask(id);
    await _fetchTasks();
  }
}
