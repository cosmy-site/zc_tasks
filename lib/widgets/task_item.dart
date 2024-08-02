import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

class TaskItem extends StatelessWidget {
  final String taskName;
  final DateTime deadline;

  const TaskItem({Key? key, required this.taskName, required this.deadline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Форматируем дедлайн в нужном формате
    String formattedDeadline = DateFormat('dd.MM.yy HH:mm').format(deadline);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Дедлайн: $formattedDeadline', // Используем отформатированный дедлайн
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
