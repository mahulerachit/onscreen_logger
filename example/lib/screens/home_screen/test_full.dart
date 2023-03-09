import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestFull extends StatefulWidget {
  TestFull({Key? key}) : super(key: key) {
    if (kDebugMode) {
      print("Test full constructor");
    }
  }

  @override
  State<TestFull> createState() {
    return _TestFullState();
  }
}

class _TestFullState extends State<TestFull> {
  @override
  Widget build(BuildContext context) {
    var list = [Colors.red, Colors.black, Colors.blue, Colors.purpleAccent];

// generates a new Random object
    final random = Random();

// generate a random index based on the list length
// and use it to retrieve the element
    var element = list[random.nextInt(list.length)];
    if (kDebugMode) {
      print("Build called");
    }
    return Container(
      color: element,
      width: 100,
      height: 100,
    );
  }

  @override
  void initState() {
    if (kDebugMode) {
      print("Init state called");
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        print("Binding observer called");
      }
    });
  }
}
