import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zc_tasks/widgets/task_item.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Ссылка на коллекцию "tasks" в Firestore
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    // Используем StreamBuilder для подписки на изменения в коллекции
    return StreamBuilder<QuerySnapshot>(
      stream: tasksCollection.snapshots(), // Получаем поток изменений
      builder: (context, snapshot) {
        // Обработка ошибок
        if (snapshot.hasError) {
          print('Ошибка при получении данных: ${snapshot.error}');
          return Center(
              child: Text('Ошибка при получении данных: ${snapshot.error}'));
        }

        // Ожидание загрузки данных
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Получение данных из snapshot
        if (!snapshot.hasData) {
          return const Center(child: Text('Нет данных'));
        }

        final tasks = snapshot.data!.docs;

        // Проверка, есть ли задачи
        if (tasks.isEmpty) {
          return const Center(child: Text('Все сделано, время отдыхать!'));
        }

        // Отображение списка задач
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            try {
              // Извлечение данных из документа
              final taskData = tasks[index].data() as Map<String, dynamic>;
              final taskName = taskData['name'];
              final deadline = taskData['deadline'] != null
                  ? (taskData['deadline'] as Timestamp).toDate()
                  : DateTime.now(); // или другое значение по умолчанию

              // Создание элемента списка задач
              return TaskItem(
                taskName: taskName,
                deadline: deadline,
              );
            } catch (e) {
              print('Ошибка при обработке документа: $e');
              return ListTile(
                title: Text('Ошибка при обработке задачи'),
                subtitle: Text('Документ: ${tasks[index].id}'),
              );
            }
          },
        );
      },
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:zc_tasks/widgets/task_item.dart';

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   // Список задач (замените на реальные данные)
//   final List<String> tasks = [
//     'Купить продукты',
//     'Записаться на прием к врачу',
//     'Отправить отчет',
//     'Позвонить другу',
//     'Сделать уборку',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return TaskItem(
//           taskName: tasks[index],
//           deadline: DateTime.now(),
//         );
//       },
//     );
//   }
// }
