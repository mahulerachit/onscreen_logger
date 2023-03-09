//This code will be the part of debugger // No performance test needed or
//Extensive review needed
import '../onscreen_logger_controller/controller.dart';

class OnScreenDebugHelperController extends OnscreenController<bool> {
  @override
  bool initDefaultValue() {
    return false;
  }

  void setTrue() {
    emit(true);
  }

  void setFalse() {
    emit(false);
  }
}

class ShowOverlayBloc extends OnscreenController<bool> {
  @override
  bool initDefaultValue() {
    return false;
  }

  void show() {
    emit(true);
  }

  void hide() {
    emit(false);
  }
}
