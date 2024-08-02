import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Объект для работы с Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Получение текущего пользователя
  User? get user => _auth.currentUser;

  // Метод для анонимной авторизации
  Future<void> signInAnonymously() async {
    try {
      // Анонимная авторизация
      await _auth.signInAnonymously();
    } catch (e) {
      // Обработка ошибок
      print('Ошибка анонимной авторизации: ${e.toString()}');
    }
  }

  // Метод для регистрации с помощью email и пароля
  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // Регистрация пользователя
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Обработка ошибок
      print('Ошибка регистрации: ${e.toString()}');
      return null;
    }
  }

  // Метод для входа с помощью email и пароля
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Вход пользователя
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Обработка ошибок
      print('Ошибка входа: ${e.toString()}');
      return null;
    }
  }

  // Метод для отправки запроса подтверждения почты
  Future<void> sendEmailVerification() async {
    try {
      // Получение текущего пользователя
      final user = _auth.currentUser;

      // Отправка запроса подтверждения почты
      await user!.sendEmailVerification();
    } catch (e) {
      // Обработка ошибок
      print('Ошибка отправки запроса подтверждения почты: ${e.toString()}');
    }
  }

  // Метод для выхода из системы
  Future<void> signOut() async {
    try {
      // Выход из Firebase
      await _auth.signOut();
    } catch (e) {
      // Обработка ошибок
      print('Ошибка выхода из системы: ${e.toString()}');
    }
  }
}
