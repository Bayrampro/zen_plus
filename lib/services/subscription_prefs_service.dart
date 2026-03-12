import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionPrefsService {
  const SubscriptionPrefsService();

  static const String _isSubscribedKey = 'is_subscribed';

  Future<bool> loadIsSubscribed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSubscribedKey) ?? false;
  }

  Future<void> saveIsSubscribed(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSubscribedKey, value);
  }
}
