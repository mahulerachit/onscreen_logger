import 'package:flutter/material.dart';

import '../screens/home_screen/home_screen.dart';

class AppRoutes {
  // Route name constants
  static const String homeScreen = '/splashScreen';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      homeScreen: (context) => const HomeScreen(),
    };
  }
}
