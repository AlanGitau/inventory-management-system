import 'package:shared_preferences/shared_preferences.dart';

class TrialService {
  static const String _firstLaunchKey = 'first_launch_date';
  static const int trialDurationDays = 14;

  /// Returns the first launch date, or sets it to now if not already set.
  static Future<DateTime> getFirstLaunchDate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? firstLaunchStr = prefs.getString(_firstLaunchKey);

    if (firstLaunchStr == null) {
      final now = DateTime.now();
      await prefs.setString(_firstLaunchKey, now.toIso8601String());
      return now;
    }

    return DateTime.parse(firstLaunchStr);
  }

  /// Checks if the trial period has expired.
  static Future<bool> isTrialExpired() async {
    final firstLaunch = await getFirstLaunchDate();
    final now = DateTime.now();
    final difference = now.difference(firstLaunch).inDays;
    
    return difference >= trialDurationDays;
  }

  /// Returns the number of days remaining in the trial.
  static Future<int> getRemainingDays() async {
    final firstLaunch = await getFirstLaunchDate();
    final now = DateTime.now();
    final difference = now.difference(firstLaunch).inDays;
    
    final remaining = trialDurationDays - difference;
    return remaining < 0 ? 0 : remaining;
  }

  /// Reset trial (for development/testing purposes only)
  static Future<void> resetTrial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstLaunchKey);
  }
}
