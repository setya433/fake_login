import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String keyUsername = 'username';
  static const String keyPassword = 'password';
  static const String keyIsLoggedIn = 'is_logged_in';

  Future<void> saveLogin({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyUsername, username);
    await prefs.setString(keyPassword, password);
    await prefs.setBool(keyIsLoggedIn, true);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername) ?? '';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(keyUsername);
    await prefs.remove(keyPassword);
    await prefs.setBool(keyIsLoggedIn, false);
  }
}