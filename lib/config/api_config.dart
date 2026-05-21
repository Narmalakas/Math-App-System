import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Emulator
      if (kDebugMode) {
        return "http://10.0.2.2/mathapp_api";
      }
    }

    // Real device
    return "http://192.168.8.138/mathapp_api";
  }
}