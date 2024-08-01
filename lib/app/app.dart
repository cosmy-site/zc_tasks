import 'package:flutter/material.dart';
import 'package:zc_tasks/pages/may_home_page.dart';
import 'package:zc_tasks/theme/theme.dart';

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
      home: const MyHomePage(title: 'Основной тайтл'),
    );
  }
}
