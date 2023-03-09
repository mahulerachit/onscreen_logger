//This code will be the part of debugger // No performance test needed or
//Extensive review needed

import 'package:flutter/material.dart';

import '../onscreen_logger_controller/controller.dart';

/// [OnScreenDebugLogController] Is used to control the state of the logs
class OnScreenDebugLogController extends OnscreenController<DebugLogs> {
  @override
  DebugLogs initDefaultValue() {
    return DebugLogs();
  }

  void addDebugLog(DebugLog debugLog) {
    state.logs.add(debugLog);
    emit(state);
  }

  Color getColorBasedOnLogType(DebugLogBannerType type) {
    switch (type) {
      case DebugLogBannerType.green:
        return Colors.green;
      case DebugLogBannerType.red:
        return Colors.red;
      case DebugLogBannerType.blue:
        return Colors.blue;
      case DebugLogBannerType.yellow:
        return Colors.yellow;
    }
  }

  void clearAll() {
    state.logs.clear();
    emit(state);
  }
}

class SingleDebugLogBloc extends OnscreenController<List<DebugLogString>> {
  @override
  List<DebugLogString> initDefaultValue() {
    return [];
  }

  void setData(List<DebugLogString> data) {
    emit(data);
  }

  void toggleBasedOnIndex(int index) {
    state.elementAt(index).isExpanded = !state.elementAt(index).isExpanded;
    emit(state);
  }
}

class DebugLogs {
  List<DebugLog> logs = [];
}

class DebugLog {
  DateTime? dateTime;
  DebugLogBannerType debugLogBannerType;
  String logTitle;
  List<DebugLogString> logStrings = [];
  DebugLog({
    required this.logTitle,
    this.debugLogBannerType = DebugLogBannerType.green,
    this.dateTime,
  });

  void setAsRed() {
    debugLogBannerType = DebugLogBannerType.red;
  }

  void setAsGreen() {
    debugLogBannerType = DebugLogBannerType.green;
  }

  void setAsBlue() {
    debugLogBannerType = DebugLogBannerType.blue;
  }

  void setAsYellow() {
    debugLogBannerType = DebugLogBannerType.yellow;
  }
}

class DebugLogString {
  String logTitle;
  String logsDescription;
  bool isExpanded;
  DebugLogString({
    required this.logTitle,
    required this.logsDescription,
    this.isExpanded = false,
  });
}

enum DebugLogBannerType {
  red,
  green,
  blue,
  yellow,
}
