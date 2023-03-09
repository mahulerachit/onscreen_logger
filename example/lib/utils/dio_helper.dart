import 'package:dio/dio.dart';
import 'package:onscreen_logger/debug_helper/debug_log_controller.dart';
import 'package:onscreen_logger/debug_helper/debug_utilities.dart';

class DioHelper {
  static void dioSuccessCall() async {
    /// Log the title of dio
    DebugLog debugLog = DebugLog(
      logTitle: "dioSuccessCall",
      dateTime: DateTime.now(),
    );

    var dioUrl = 'http://www.google.com';

    /// Log the url used for dio
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Dio URL",
        logsDescription: dioUrl,
      ),
    );

    try {
      var response = await Dio().get(dioUrl);

      /// Log the result to the ui
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result", logsDescription: response.toString()));

      /// Set Log color as green
      debugLog.setAsGreen();
    } catch (e) {
      /// Log the exception to the ui
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql exception", logsDescription: e.toString()));

      /// Set Log color as red
      debugLog.setAsRed();
    }

    /// Finally Build the Ui for log
    OnScreenDebugUtils.onScreenDebugLogController.addDebugLog(debugLog);
  }

  static void dioFailureCall() async {
    /// Log the title of dio
    DebugLog debugLog = DebugLog(
      logTitle: "dioFailureCall",
      dateTime: DateTime.now(),
    );

    //Wrong Url
    var dioUrl = 'http://www.googlee.com';

    /// Log the url used for dio
    debugLog.logStrings.add(
      DebugLogString(
        logTitle: "Dio URL",
        logsDescription: dioUrl,
      ),
    );

    try {
      var response = await Dio().get(dioUrl);

      /// Log the result to the ui
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result", logsDescription: response.toString()));

      /// Set Log color as green
      debugLog.setAsGreen();
    } catch (e) {
      /// Log the exception to the ui
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Exception", logsDescription: e.toString()));

      /// Set Log color as red
      debugLog.setAsRed();
    }

    /// Finally Build the Ui for log
    OnScreenDebugUtils.onScreenDebugLogController.addDebugLog(debugLog);
  }
}
