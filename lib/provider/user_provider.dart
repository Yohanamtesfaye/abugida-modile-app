import 'package:abugida/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProvider with ChangeNotifier {
  late Box<User> _usersBox;
  User? _loggedInUser;

  UserProvider() {
    _usersBox = Hive.box<User>('usersBox');
  }

  // Get the logged-in user
  User? get loggedInUser => _loggedInUser;

  // Login a user
  bool login(String email, String password) {
    final user = _usersBox.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(id: '', fullName: '', email: '', password: ''),
    );

    if (user.id.isNotEmpty) {
      _loggedInUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout the current user
  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  // Add a new user (Sign Up)
  Future<void> signUp(User user) async {
    await _usersBox.add(user);
    notifyListeners();
  }

  // Check if an email is already registered
  bool isEmailRegistered(String email) {
    return _usersBox.values.any((user) => user.email == email);
  }
}
