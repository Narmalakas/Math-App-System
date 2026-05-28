import 'dart:io';

class ApiConfig {
  static String get baseUrl {

    // Android Emulator
    if (Platform.isAndroid) {
      try {
        // Emulator
        if (Platform.environment.containsKey('ANDROID_EMULATOR_BUILD')) {
          return "http://10.0.2.2/mathapp_api";
        }
      } catch (_) {}
    }

    // REAL PHONE
    return "http://192.168.8.164/mathapp_api";
  }
}