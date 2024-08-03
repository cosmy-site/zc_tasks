import 'package:flutter/material.dart';
import 'package:zc_tasks/pages/login_page.dart';
import 'package:zc_tasks/services/firebase_auth.dart'; // Импорт AuthService

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService(); // Инициализация AuthService

  @override
  Widget build(BuildContext context) {
    final user = _authService.user; // Получение текущего пользователя

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Аватар
          CircleAvatar(
            radius: 50,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!) // Изображение из Firebase
                : const AssetImage(
                    'assets/avatar.png'), // Изображение по умолчанию
          ),
          const SizedBox(height: 20),
          // Почта
          Text(
            user?.email ??
                'example@email.com', // Почта пользователя или placeholder
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          // Кнопка подтверждения почты (отображается, если почта не подтверждена)
          if (!user!.emailVerified)
            ElevatedButton(
              onPressed: () async {
                // Обработка отправки запроса подтверждения почты
                await _authService.sendEmailVerification(); // Отправка запроса
                // Отображение AlertDialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Подтверждение почты'),
                      content:
                          const Text('Письмо с подтверждением отправлено.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
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
            onPressed: () async {
              // Обработка выхода из профиля
              await _authService.signOut(); // Выход из Firebase
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
