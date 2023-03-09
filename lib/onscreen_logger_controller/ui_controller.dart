import 'package:flutter/material.dart';

import 'controller.dart';

///[OnscreenUiController] is just used to rebuild the widget
class OnscreenUiController extends StatelessWidget {
  final Widget Function() builder;
  final OnscreenController bloc;
  const OnscreenUiController(
      {Key? key, required this.bloc, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        return builder();
      },
    );
  }
}
