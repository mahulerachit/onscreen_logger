import 'package:flutter/material.dart';

import '../onscreen_logger_controller/ui_controller.dart';
import 'debug_helper_bloc.dart';
import 'debug_helper_widget.dart';
import 'debug_utilities.dart';

const Offset _kInitialWidgetPosition = Offset(20.0, 20.0);
const double _kButtonHeight = 50;
const double _kButtonWidth = 50;
const Color _kButtonBackgroundColor = Colors.green;
const Color _kButtonIconColor = Colors.white;
const IconData _kIcon = Icons.developer_mode;
const double _kButtonBorderRadius = 25;

class OnscreenDebugCoreWidget extends StatefulWidget {
  const OnscreenDebugCoreWidget({Key? key}) : super(key: key);

  @override
  OnscreenDebugCoreWidgetState createState() => OnscreenDebugCoreWidgetState();
}

class OnscreenDebugCoreWidgetState extends State<OnscreenDebugCoreWidget> {
  Offset position = _kInitialWidgetPosition;

  @override
  Widget build(BuildContext context) {
    return getWidget(OnScreenDebugUtils.onScreenDebugHelperController);
  }

  Widget getWidget(
      OnScreenDebugHelperController onScreenDebugHelperController) {
    return OnscreenUiController(
        bloc: onScreenDebugHelperController,
        builder: () {
          return Stack(
            children: [
              if (onScreenDebugHelperController.state)
                OnScreenDebugHelperWidget(onScreenDebugHelperController),
              if (!onScreenDebugHelperController.state)
                Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: Draggable(
                    feedback: getButton(),
                    childWhenDragging: Container(),
                    onDragEnd: (details) {
                      setState(
                        () {
                          position = details.offset;
                        },
                      );
                    },
                    child: getButton(),
                  ),
                ),
            ],
          );
        });
  }

  Widget getButton() {
    return GestureDetector(
      onTap: () {
        OnScreenDebugUtils.onScreenDebugHelperController.setTrue();
      },
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }
}
