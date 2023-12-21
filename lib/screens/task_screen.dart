import 'package:flutter/material.dart';
import 'package:interview_task/models/task_models.dart';
import 'package:interview_task/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'task_add_screen.dart';
import 'task_edit_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String _selectedSortOption = 'Default'; // Default sort option

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.initializeDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          _buildSortDropdown(),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          final tasks = _getSortedTasks(provider.tasks);

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                title: Text("ID: ${task.id} - ${task.title}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ${task.description}"),
                    Text("Status: ${task.status}"),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditScreen(task: task),
                    ),
                  );
                },
                onLongPress: () {
                  _showDeleteDialog(context, taskProvider, task.id!);
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskEditScreen(task: task),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteDialog(context, taskProvider, task.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskAddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return DropdownButton<String>(
      value: _selectedSortOption,
      items: ['Default', 'Title', 'Status'].map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedSortOption = value!;
        });
      },
    );
  }

  List<Task> _getSortedTasks(List<Task> tasks) {
    switch (_selectedSortOption) {
      case 'Title':
        return tasks..sort((a, b) => a.title.compareTo(b.title));
      case 'Status':
        return tasks..sort((a, b) => a.status.compareTo(b.status));
      default:
        return tasks;
    }
  }

  Future<void> _showDeleteDialog(
      BuildContext context, TaskProvider provider, int taskId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await provider.deleteTask(taskId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
