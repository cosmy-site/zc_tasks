import 'package:flutter/material.dart';
import 'package:zc_tasks/theme/theme.dart';
import 'package:zc_tasks/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TasksTheme.darkTheme, // Use light theme
      home: const LoginPage(),
    );
  }
}
