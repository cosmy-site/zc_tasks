import 'package:flutter/material.dart';

class TasksTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // Светлая тема
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F88F7), // Основной цвет (кнопки, ссылки)
      brightness: Brightness.light, // Светлая тема
      primary: const Color(0xFF3F88F7), // Основной цвет
      onPrimary: Colors.white, // Цвет текста на основном фоне
      secondary: Color(0xFFEAEAEA), // Вторичный цвет (заголовки, текст)
      onSecondary: Colors.black, // Цвет текста на вторичном фоне
      error: Colors.red, // Цвет ошибки
      onError: Colors.white, // Цвет текста на ошибке
      background: const Color(0xFFFFFFFF), // Цвет фона
      onBackground: Colors.black, // Цвет текста на фоне
      surface:
          const Color(0xFF1E1E1E), // Цвет поверхностей (шапка, карты, диалоги)
      onSurface: Colors.black, // Цвет текста на поверхностях
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // Фон BottomNavigationBar
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFF3F88F7), // Цвет активных иконок и текста
      unselectedItemColor: Color(0xFFEAEAEA), // Цвет неактивных иконок и текста
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Темная тема
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F88F7), // Основной цвет (кнопки, ссылки)
      brightness: Brightness.dark, // Темная тема
      primary: const Color(0xFF3F88F7), // Основной цвет
      onPrimary: Colors.white, // Цвет текста на основном фоне
      secondary: const Color(0xFFEAEAEA), // Вторичный цвет (заголовки, текст)
      onSecondary: Colors.black, // Цвет текста на вторичном фоне
      error: Colors.red, // Цвет ошибки
      onError: Colors.white, // Цвет текста на ошибке
      background: const Color(0xFF000000), // Цвет фона
      onBackground: Colors.white, // Цвет текста на фоне
      surface:
          const Color(0xFF1E1E1E), // Цвет поверхностей (шапка, карты, диалоги)
      onSurface: Colors.white, // Цвет текста на поверхностях
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // Фон BottomNavigationBar
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFF3F88F7), // Цвет активных иконок и текста
      unselectedItemColor: Color(0xFFEAEAEA), // Цвет неактивных иконок и текста
    ),
  );
}
