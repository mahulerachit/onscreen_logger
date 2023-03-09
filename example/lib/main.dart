import 'package:example/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:onscreen_logger/debug_helper/debug_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      builder: (context, child) {
        return OnScreenDebugWidget(
          child: child ?? const SizedBox(),
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.getRoutes(),
    );
  }
}
