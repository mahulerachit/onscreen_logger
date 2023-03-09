import 'dart:convert';

import 'debug_helper_bloc.dart';
import 'debug_log_controller.dart';

class OnScreenDebugUtils {
  static final OnScreenDebugHelperController onScreenDebugHelperController =
      OnScreenDebugHelperController();
  static OnScreenDebugLogController onScreenDebugLogController =
      OnScreenDebugLogController();

  /// [getMapToString] converts map to string format
  static String getMapToString(Map<String, dynamic>? data) {
    if (data == null) return "null";
    try {
      return jsonEncode(data);
    } catch (_) {
      return data.toString();
    }
  }
}
