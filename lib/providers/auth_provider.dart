
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String pass) async {
    final user = await _service.signIn(email, pass);
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> signup(String email, String pass) async {
    final user = await _service.signUp(email, pass);
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    final user = await _service.signInWithGoogle();
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _service.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}
