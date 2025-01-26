
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_variables.dart';
import '../constants/static_data.dart';

// Define a constant for the access token key
const String accessTokenKey = 'access_token';
const String isSellerOnboardedText = 'isSellerOnboarded';

class SharedPreferencesHelper {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences and StaticData
  static Future<void> getInitialValue() async {
    _prefs = await SharedPreferences.getInstance();
    StaticData.isFirstTime = getBool(isFirstTimeText) ?? true;
    StaticData.isBuyer = getBool(isBuyerText) ?? true;
    StaticData.isLoggedIn = getBool(isLoggedInText) ?? false;
    StaticData.isSellerOnboarded = getBool(isSellerOnboardedText) ?? false;
    StaticData.email = getString(emailText) ?? '';

    // Load the access token into StaticData
    StaticData.accessToken = getString(accessTokenKey) ?? '';
  }

  // Save a boolean value and update StaticData
  static Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);

    // Update StaticData
    if (key == isBuyerText) {
      StaticData.isBuyer = value;
    }
    if (key == isLoggedInText) {
      StaticData.isLoggedIn = value;
    }
    if (key == isSellerOnboardedText) {
      StaticData.isSellerOnboarded = value;
    }
  }

  // Save the access token
  static Future<void> saveAccessToken(String token) async {
    await _prefs.setString(accessTokenKey, token);
    StaticData.accessToken = token; // Update StaticData
  }

  // Retrieve the access token
  static String? getAccessToken() {
    return _prefs.getString(accessTokenKey);
  }

  // Retrieve a boolean value
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Add this method for retrieving a string value
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save a string value
  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Remove a value
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all values
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
