import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/token_storage.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _token;
  UserModel? _user;
  dynamic _userId;

  final AuthService _authService = AuthService();

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;
  UserModel? get user => _user;
  String? get token => _token;
  dynamic get userId => _userId;

  AuthProvider() {
    _initAutoLogin();
  }

  Future<void> _initAutoLogin() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _token = await currentUser.getIdToken();
      _userId = currentUser.uid;
      _user = UserModel(
        id: _userId,
        username: currentUser.displayName ?? currentUser.email ?? 'User',
        email: currentUser.email ?? '',
      );
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await _authService.signInWithEmail(email, password);
      if (userCredential != null && userCredential.user != null) {
        _handleUserAuth(userCredential.user!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        _handleUserAuth(userCredential.user!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await _authService.signUpWithEmail(email, password);
      if (userCredential != null && userCredential.user != null) {
        _handleUserAuth(userCredential.user!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleUserAuth(User user) async {
    _token = await user.getIdToken();
    _userId = user.uid;
    _user = UserModel(
      id: _userId,
      username: user.displayName ?? user.email ?? 'User',
      email: user.email ?? '',
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.signOut();
    _token = null;
    _user = null;
    _userId = null;
    await TokenStorage.clearToken();
    notifyListeners();
  }
}