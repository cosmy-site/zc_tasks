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

    // Определяем цвет кружка в зависимости от срочности
    Color circleColor = Colors.green; // По умолчанию - зеленый
    Duration timeUntilDeadline = deadline.difference(DateTime.now());
    if (timeUntilDeadline.inDays < 1) {
      circleColor = Colors.red; // Срочная задача
    } else if (timeUntilDeadline.inDays < 2) {
      circleColor = Colors.yellow; // Задача средней срочности
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Убираем Row с кружком справа сверху
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Text(
            //         taskName,
            //         style: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       // Кружок с цветом приоритета
            //       margin: const EdgeInsets.only(right: 16.0), // Отступ справа
            //       width: 20,
            //       height: 20,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: circleColor,
            //       ),
            //     ),
            //   ],
            // ),
            Text(
              taskName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // Добавляем Row для кружка и текста дедлайна
                  children: [
                    Container(
                      // Кружок с цветом приоритета
                      margin:
                          const EdgeInsets.only(right: 8.0), // Отступ справа
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: circleColor,
                      ),
                    ),
                    Text(
                      'Дедлайн: $formattedDeadline',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Обработка нажатия на кнопку редактирования
                        // Например, можно открыть диалог редактирования задачи
                        print('Редактировать задачу');
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // Обработка нажатия на кнопку удаления
                        // Например, можно показать диалог подтверждения удаления
                        print('Удалить задачу');
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
