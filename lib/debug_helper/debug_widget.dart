import 'package:flutter/material.dart';

import 'debug_core_widget.dart';

/// [OnScreenDebugWidget] creates a on screen Ui Overlay
class OnScreenDebugWidget extends StatelessWidget {
  final Widget child;
  const OnScreenDebugWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => const OnscreenDebugCoreWidget(),
            ),
          ],
        ),
      ],
    );
  }
}
