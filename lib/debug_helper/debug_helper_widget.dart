import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../onscreen_logger_controller/ui_controller.dart';
import 'debug_helper_bloc.dart';
import 'debug_log_controller.dart';
import 'debug_utilities.dart';

const double _kButtonHeight = 50;
const double _kButtonWidth = 50;
const Color _kButtonBackgroundColor = Colors.green;
const Color _kButtonBackgroundRedColor = Colors.red;
const Color _kButtonIconColor = Colors.white;
const double _kButtonBorderRadius = 25;
const IconData _kArrowBackIcon = Icons.arrow_back;
const IconData _kDeleteIcon = Icons.delete_forever;
const IconData _kCopyIcon = Icons.copy_all;
const double _kGeneralPadding = 10;
const double _kDividerHeight = 1;
const Color _kDividerColor = Colors.grey;
const double _kBannerHeight = 60;
const int _kMaxLines = 2;
const double _kFontSize = 18;
const double _kFontSize14 = 14;
const double _kPadding8 = 8;
const int _kAnimationDuration = 200;

/// [OnScreenDebugHelperWidget] Is a overlay widget with all data inside it.
class OnScreenDebugHelperWidget extends StatelessWidget {
  final OnScreenDebugHelperController testBloc;
  OnScreenDebugHelperWidget(this.testBloc, {Key? key}) : super(key: key);

  Widget getCancelButton() {
    return GestureDetector(
      onTap: () {
        testBloc.setFalse();
      },
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kArrowBackIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }

  Widget getClearButton() {
    return GestureDetector(
      onTap: () {
        OnScreenDebugUtils.onScreenDebugLogController.clearAll();
      },
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundRedColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kDeleteIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }

  Widget getCopyButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kCopyIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }

  final ShowOverlayBloc showOverlayBloc = ShowOverlayBloc();
  @override
  Widget build(BuildContext context) {
    return OnscreenUiController(
        bloc: showOverlayBloc,
        builder: () {
          if (showOverlayBloc.state) {
            return ShowOverlay(showOverlayBloc);
          }
          return getListerWidget();
        });
  }

  Widget getListerWidget() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: _kGeneralPadding,
                ),
                getCancelButton(),
                const Spacer(),
                getClearButton(),
                const SizedBox(
                  width: _kGeneralPadding,
                ),
              ],
            ),
            const SizedBox(
              height: _kGeneralPadding,
            ),
            Container(
              height: _kDividerHeight,
              color: _kDividerColor,
            ),
            Expanded(
              child: getListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListView() {
    return OnscreenUiController(
        bloc: OnScreenDebugUtils.onScreenDebugLogController,
        builder: () {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ShowOverlay.bloc.setData(OnScreenDebugUtils
                      .onScreenDebugLogController.state.logs
                      .elementAt(index)
                      .logStrings);
                  showOverlayBloc.show();
                },
                child: Container(
                  height: _kBannerHeight,
                  color: OnScreenDebugUtils.onScreenDebugLogController
                      .getColorBasedOnLogType(OnScreenDebugUtils
                          .onScreenDebugLogController.state.logs
                          .elementAt(index)
                          .debugLogBannerType),
                  margin: const EdgeInsets.fromLTRB(_kGeneralPadding,
                      _kGeneralPadding, _kGeneralPadding, _kGeneralPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: _kGeneralPadding),
                          child: Text(
                            OnScreenDebugUtils
                                .onScreenDebugLogController.state.logs
                                .elementAt(index)
                                .logTitle,
                            maxLines: _kMaxLines,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: _kFontSize,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: _kGeneralPadding),
                            child: Text(
                              getFormatedDate(index),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: _kFontSize14,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: _kGeneralPadding),
                            child: Text(
                              "Log Count : $index",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: _kFontSize14,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount:
                OnScreenDebugUtils.onScreenDebugLogController.state.logs.length,
          );
        });
  }

  String getFormatedDate(int index) {
    return "${(OnScreenDebugUtils.onScreenDebugLogController.state.logs.elementAt(index).dateTime?.hour ?? 00).toString().padLeft(2, '0')}:${(OnScreenDebugUtils.onScreenDebugLogController.state.logs.elementAt(index).dateTime?.minute ?? 00).toString().padLeft(2, '0')}:${(OnScreenDebugUtils.onScreenDebugLogController.state.logs.elementAt(index).dateTime?.second ?? 00).toString().padLeft(2, '0')}";
  }
}

class ShowOverlay extends StatelessWidget {
  final ShowOverlayBloc showOverlayBloc;
  static SingleDebugLogBloc bloc = SingleDebugLogBloc();
  const ShowOverlay(this.showOverlayBloc, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return OnscreenUiController(
          bloc: bloc,
          builder: () {
            return getListerDetailWidget(context);
          });
    });
  }

  Widget getCopyButton({String copyText = ""}) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: copyText));
      },
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kCopyIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }

  Widget getCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOverlayBloc.hide();
      },
      child: Container(
        width: _kButtonWidth,
        height: _kButtonHeight,
        decoration: BoxDecoration(
          color: _kButtonBackgroundColor,
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        ),
        child: const Icon(
          _kArrowBackIcon,
          color: _kButtonIconColor,
        ),
      ),
    );
  }

  Widget getListerDetailWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 10,
                ),
                getCancelButton(context),
                const Spacer(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: getTitledListerCreater(bloc.state),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitledListerCreater(List<DebugLogString> data) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        children: listOfDebugData(data),
        animationDuration: const Duration(milliseconds: _kAnimationDuration),
        expandedHeaderPadding: const EdgeInsets.all(_kPadding8),
        expansionCallback: (panelIndex, isExpanded) {
          bloc.toggleBasedOnIndex(panelIndex);
        },
      ),
    );
  }

  List<ExpansionPanel> listOfDebugData(List<DebugLogString> data) {
    List<ExpansionPanel> pannels = [];
    for (DebugLogString datas in data) {
      pannels.add(
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Text(
              datas.logTitle,
              maxLines: _kMaxLines,
              style: const TextStyle(
                color: Colors.black,
                fontSize: _kFontSize,
              ),
            );
          },
          canTapOnHeader: true,
          isExpanded: datas.isExpanded,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: _kGeneralPadding),
                child: getCopyButton(copyText: datas.logsDescription),
              ),
              const SizedBox(
                height: _kGeneralPadding,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(_kGeneralPadding),
                child: SelectableText(
                  datas.logsDescription,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: _kFontSize14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return pannels;
  }
}
