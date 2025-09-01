import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String isLoggedInVar = "isLoggedInVar";

  static Future<bool> isLoggedIn() async {
    final key = await SharedPreferences.getInstance();
    return key.getBool(isLoggedInVar) ?? false;
  }

  static Future<void> logIn() async {
    final key = await SharedPreferences.getInstance();
    key.setBool(isLoggedInVar, true);
  }

  static Future<void> logOut() async {
    final key = await SharedPreferences.getInstance();
    key.setBool(isLoggedInVar, false);
  }
}
