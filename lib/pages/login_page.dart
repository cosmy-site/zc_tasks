import 'package:flutter/material.dart';
import 'package:zc_tasks/pages/main_page.dart';
import 'package:zc_tasks/services/firebase_auth.dart'; // Импорт AuthService

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Ключ для управления состоянием формы
  final _formKey = GlobalKey<FormState>();
  // Контроллеры для текстовых полей
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController(); // Контроллер для поля подтверждения пароля

  // Флаг для переключения между режимами входа и регистрации
  bool _isLoginMode = true;

  // Флаг для показа/скрытия пароля
  bool _showPassword = false;

  // Экземпляр AuthService
  final AuthService _authService = AuthService();

  // Сообщение об ошибке
  String? _errorMessage;

  // Освобождение ресурсов контроллеров при выходе из виджета
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController
        .dispose(); // Освобождение ресурсов контроллера подтверждения пароля
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Центрируем форму по вертикали
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Отступы для содержимого
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Центрируем по вертикали
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Центрируем название по горизонтали
              children: [
                // Логотип
                Image.asset(
                  'assets/logo.png', // Замените на путь к вашему логотипу
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                    height: 16.0), // Отступ между логотипом и названием
                // Название приложения
                const Text(
                  'Personal.Guide',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center, // Выравниваем текст по центру
                ),
                const SizedBox(height: 32.0), // Отступ между названием и формой
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Form(
                  key: _formKey, // Ключ для управления формой
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Центрируем по вертикали
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch, // Выравнивание по ширине
                    children: [
                      // Поле ввода почты для входа и регистрации
                      TextFormField(
                        controller:
                            _emailController, // Контроллер для поля почты
                        decoration: const InputDecoration(
                          labelText: 'Почта', // Подсказка для поля
                        ),
                        validator: (value) {
                          // Валидация поля почты
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите почту'; // Сообщение об ошибке
                          }
                          if (!value.contains('@')) {
                            return 'Некорректный формат почты'; // Сообщение об ошибке
                          }
                          return null; // Нет ошибки
                        },
                      ),
                      const SizedBox(height: 16.0), // Отступ между полями
                      TextFormField(
                        controller:
                            _passwordController, // Контроллер для поля пароля
                        obscureText: !_showPassword, // Скрытие текста пароля
                        decoration: InputDecoration(
                          labelText: 'Пароль', // Подсказка для поля
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Переключение показа/скрытия пароля
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons
                                    .visibility_off), // Иконка для показа/скрытия
                          ),
                        ),
                        validator: (value) {
                          // Валидация поля пароля
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите пароль'; // Сообщение об ошибке
                          }
                          return null; // Нет ошибки
                        },
                      ),
                      if (!_isLoginMode) // Поле подтверждения пароля только для регистрации
                        const SizedBox(height: 16.0), // Отступ между полями
                      if (!_isLoginMode)
                        TextFormField(
                          controller:
                              _confirmPasswordController, // Контроллер для поля подтверждения пароля
                          obscureText: !_showPassword, // Скрытие текста пароля
                          decoration: InputDecoration(
                            labelText: 'Повторите пароль', // Подсказка для поля
                            suffixIcon: IconButton(
                              onPressed: () {
                                // Переключение показа/скрытия пароля
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(_showPassword
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off), // Иконка для показа/скрытия
                            ),
                          ),
                          validator: (value) {
                            // Валидация поля подтверждения пароля
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, повторите пароль'; // Сообщение об ошибке
                            }
                            if (value != _passwordController.text) {
                              return 'Пароли не совпадают'; // Сообщение об ошибке
                            }
                            return null; // Нет ошибки
                          },
                        ),
                      const SizedBox(height: 32.0), // Отступ перед кнопкой
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary, // Основной цвет
                          foregroundColor: Colors.white, // Белый текст
                        ),
                        onPressed: () async {
                          // Обработка нажатия на кнопку "Войти" или "Зарегистрироваться"
                          if (_formKey.currentState!.validate()) {
                            // Проверка валидности формы
                            setState(() {
                              _errorMessage = null;
                            });

                            try {
                              if (_isLoginMode) {
                                // Логин
                                final userCredential = await _authService
                                    .signInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (userCredential != null) {
                                  // Переход на главную страницу
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainPage()),
                                  );
                                }
                              } else {
                                // Регистрация
                                final userCredential = await _authService
                                    .createUserWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (userCredential != null) {
                                  // Переход на страницу входа
                                  setState(() {
                                    _isLoginMode = true;
                                  });
                                }
                              }
                            } catch (e) {
                              setState(() {
                                _errorMessage = e.toString();
                              });
                            }
                          }
                        },
                        child: Text(_isLoginMode
                            ? 'Войти'
                            : 'Зарегистрироваться'), // Текст на кнопке
                      ),
                      const SizedBox(
                          height: 16.0), // Отступ перед текстовой кнопкой
                      TextButton(
                        onPressed: () {
                          // Переключение между режимами входа и регистрации
                          setState(() {
                            _isLoginMode = !_isLoginMode;
                          });
                        },
                        child: Text(
                          _isLoginMode
                              ? 'У меня ещё нет аккаунта'
                              : 'Уже есть аккаунт? Войти', // Текст на кнопке
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
