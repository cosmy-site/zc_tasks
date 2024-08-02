import 'package:flutter/material.dart';
import 'package:zc_tasks/screens/all_tasks.dart';
import 'package:zc_tasks/theme/theme.dart';
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
    );
  }
}
