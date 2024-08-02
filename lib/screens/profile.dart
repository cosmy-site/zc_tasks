import 'package:flutter/material.dart';
import '../pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEmailVerified = false; // Флаг для проверки подтверждения почты

  void _showNotificationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E), // Фон диалога
        title: const Text(
          'Уведомление',
          style: TextStyle(color: Colors.white), // Белый текст заголовка
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white), // Белый текст сообщения
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white), // Белый текст кнопки
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Аватар
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/avatar.png'), // Замените на реальный путь к аватару
          ),
          const SizedBox(height: 20),
          // Почта
          const Text(
            'example@email.com', // Замените на реальную почту пользователя
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          // Кнопка подтверждения почты (отображается, если почта не подтверждена)
          if (!isEmailVerified)
            ElevatedButton(
              onPressed: () {
                // Обработка отправки запроса подтверждения почты
                // Например, можно показать диалог с сообщением о том, что письмо отправлено
                _showNotificationDialog(
                    'Письмо с подтверждением отправлено на ваш адрес.');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Подтвердить почту'),
            ),
          const SizedBox(height: 20),
          // Кнопка выхода из профиля
          TextButton(
            onPressed: () {
              // Обработка выхода из профиля
              // Например, можно перейти на страницу входа
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Красный цвет для текста кнопки
            ),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}
