import 'package:flutter/material.dart';
import 'package:interview_task/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter SQLite CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w600),
            bodySmall: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
            ),
          ),
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
