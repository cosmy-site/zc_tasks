import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zc_tasks/screens/all_tasks.dart';
import 'package:zc_tasks/screens/profile.dart'; // Импорт profile_page

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Индекс выбранной вкладки
  int _selectedIndex = 0;

  // Список виджетов для каждой вкладки
  static const List<Widget> _widgetOptions = <Widget>[
    TaskPage(), // Виджет для вкладки "Задачи"
    Text('Сегодня'), // Виджет для вкладки "Сегодня"
    Text('Выполнено'), // Виджет для вкладки "Выполнено"
    ProfilePage(), // Виджет для вкладки "Профиль"
  ];

  // Список заголовков для каждой вкладки
  static const List<String> _titles = <String>[
    'Задачи', // Заголовок для вкладки "Задачи"
    'Сегодня', // Заголовок для вкладки "Сегодня"
    'Выполнено', // Заголовок для вкладки "Выполнено"
    'Профиль', // Заголовок для вкладки "Профиль"
  ];

  // Обработчик нажатия на вкладку
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновление индекса выбранной вкладки
    });
  }

  // Функция для показа диалогового окна добавления задачи
  void _showAddTaskDialog() {
    // Создаем контроллеры для текстовых полей диалога
    final taskNameController = TextEditingController();
    final taskDescriptionController =
        TextEditingController(); // Контроллер для описания
    final deadlineController = TextEditingController();
    DateTime? selectedDeadline; // Переменная для хранения выбранного дедлайна

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // Используем Dialog вместо AlertDialog
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Отступы для содержимого
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Заголовок диалога
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Добавить задачу',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Поле ввода названия задачи
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: taskNameController,
                    decoration: const InputDecoration(
                      labelText: 'Название задачи',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Поле ввода описания задачи
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: taskDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Описание задачи',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Поле выбора дедлайна
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: deadlineController,
                          decoration: const InputDecoration(
                            labelText: 'Дедлайн',
                          ),
                          readOnly: true, // Делаем поле только для чтения
                          onTap: () async {
                            // Открываем календарь для выбора даты и времени
                            selectedDeadline = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (selectedDeadline != null) {
                              // Если дата выбрана, открываем TimePicker для выбора времени
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                // Обновляем контроллер дедлайна с выбранной датой и временем
                                selectedDeadline = DateTime(
                                  selectedDeadline!.year,
                                  selectedDeadline!.month,
                                  selectedDeadline!.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                deadlineController.text =
                                    DateFormat('yyyy-MM-dd HH:mm')
                                        .format(selectedDeadline!);
                              }
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // Открываем календарь для выбора даты и времени
                          selectedDeadline = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDeadline != null) {
                            // Если дата выбрана, открываем TimePicker для выбора времени
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              // Обновляем контроллер дедлайна с выбранной датой и временем
                              selectedDeadline = DateTime(
                                selectedDeadline!.year,
                                selectedDeadline!.month,
                                selectedDeadline!.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                              deadlineController.text =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(selectedDeadline!);
                            }
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Кнопки "Отмена" и "Добавить"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Кнопка отмены
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отмена'),
                      ),
                      // Кнопка подтверждения
                      TextButton(
                        onPressed: () {
                          // Получаем значения из текстовых полей
                          String taskName = taskNameController.text;
                          String taskDescription = taskDescriptionController
                              .text; // Получаем описание
                          DateTime? deadline = selectedDeadline;

                          // Проверяем, что поля не пустые
                          if (taskName.isNotEmpty && deadline != null) {
                            // Добавляем новую задачу (здесь нужно реализовать логику добавления)
                            // Например, можно добавить задачу в список задач
                            // ...

                            // Закрываем диалоговое окно
                            Navigator.pop(context);
                          } else {
                            // Показываем сообщение об ошибке, если поля пустые
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Пожалуйста, заполните все поля'),
                              ),
                            );
                          }
                        },
                        child: const Text('Добавить'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), // Заголовок страницы
      ),
      backgroundColor: const Color(0xFF000000), // Общий фон страницы
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Отображение виджета выбранной вкладки
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(
              0xFF1E1E1E), // Принудительно устанавливаем цвет фона BottomNavigationBar
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Задачи', // Текст для вкладки "Задачи"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Сегодня', // Текст для вкладки "Сегодня"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: 'Выполнено', // Текст для вкладки "Выполнено"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль', // Текст для вкладки "Профиль"
            ),
          ],
          currentIndex: _selectedIndex, // Индекс текущей выбранной вкладки
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: _onItemTapped, // Обработчик нажатия на вкладку
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Вызываем диалоговое окно при нажатии
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
