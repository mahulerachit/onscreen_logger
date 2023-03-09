import 'dart:async';

///[OnscreenUiController] is just used to Handle the state
abstract class OnscreenController<T> {
  late T _t;
  final _streamController = StreamController<T>.broadcast();
  Stream<T> get stream => _streamController.stream;
  T get state => _t;
  OnscreenController() {
    _t = initDefaultValue();
    _streamController.sink.add(_t);
  }
  T initDefaultValue();

  ///[emit] is just used to update the state and also sinks with stream controller
  void emit(T data) {
    if (!_streamController.isClosed) {
      _t = data;
      _streamController.sink.add(data);
    }
  }
}
