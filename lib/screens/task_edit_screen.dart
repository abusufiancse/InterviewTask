import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview_task/models/task_models.dart';
import 'package:interview_task/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;

  TaskEditScreen({Key? key, required this.task}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _statusController.text = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
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
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final description = _descriptionController.text;
                final status = _statusController.text;

                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    status.isNotEmpty) {
                  final updatedTask = Task(
                      id: widget.task.id,
                      title: title,
                      description: description,
                      status: status);
                  await Provider.of<TaskProvider>(context, listen: false)
                      .updateTask(updatedTask);

                  Fluttertoast.showToast(
                    msg: "Task updated successfully",
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
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
