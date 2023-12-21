import 'package:flutter/material.dart';
import 'package:interview_task/models/task_models.dart';
import 'package:interview_task/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskAddScreen extends StatefulWidget {
  TaskAddScreen({Key? key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  TaskStatus _selectedStatus = TaskStatus.NotStarted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            _buildStatusDropdown(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final description = _descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  final task = Task(
                    title: title,
                    description: description,
                    status: _selectedStatus,
                    id: null,
                  );

                  await Provider.of<TaskProvider>(context, listen: false)
                      .addTask(task);

                  Fluttertoast.showToast(
                    msg: "Task added successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );

                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                    msg: "Please fill in all fields",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<TaskStatus>(
      value: _selectedStatus,
      items: TaskStatus.values.map((status) {
        return DropdownMenuItem<TaskStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
      onChanged: (value) {
        _selectedStatus = value!;
      },
    );
  }
}
