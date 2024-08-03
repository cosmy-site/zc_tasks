import 'package:flutter/material.dart';
import 'package:zc_tasks/pages/main_page.dart';
import 'package:zc_tasks/services/firebase_auth.dart'; // Импорт AuthService

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoginMode = true;
  bool _showPassword = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Personal.Guide',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Почта',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите почту';
                            }
                            if (!value.contains('@')) {
                              return 'Некорректный формат почты';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(_showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите пароль';
                            }
                            return null;
                          },
                        ),
                        if (!_isLoginMode) const SizedBox(height: 16.0),
                        if (!_isLoginMode)
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: 'Повторите пароль',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, повторите пароль';
                              }
                              if (value != _passwordController.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                          ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_isLoginMode) {
                                final userCredential = await _authService
                                    .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                                if (userCredential != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage()));
                                } else {
                                  _showError(
                                      'Ошибка входа. Пожалуйста, проверьте свои данные.');
                                }
                              } else {
                                final userCredential = await _authService
                                    .createUserWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                                if (userCredential != null) {
                                  setState(() {
                                    _isLoginMode = true;
                                  });
                                } else {
                                  _showError(
                                      'Ошибка регистрации. Возможно, такой email уже зарегистрирован.');
                                }
                              }
                            }
                          },
                          child: Text(
                              _isLoginMode ? 'Войти' : 'Зарегистрироваться'),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLoginMode = !_isLoginMode;
                            });
                          },
                          child: Text(_isLoginMode
                              ? 'У меня ещё нет аккаунта'
                              : 'Уже есть аккаунт? Войти'),
                        ),
                      ],
                    ),
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
