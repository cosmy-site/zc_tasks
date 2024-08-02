import 'package:flutter/material.dart';
import 'package:zc_tasks/widgets/task_item.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Список задач (замените на реальные данные)
  final List<String> tasks = [
    'Купить продукты',
    'Записаться на прием к врачу',
    'Отправить отчет',
    'Позвонить другу',
    'Сделать уборку',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          taskName: tasks[index],
          deadline: DateTime.now(),
        );
      },
    );
  }
}
