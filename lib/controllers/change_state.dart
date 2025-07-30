import '../contracts/observable.dart';

class ChangeState extends Observable{
  final List<void Function()> _callbacks = [];

  @override
  void addListener(void Function() callback) {
    if (!_callbacks.contains(callback)) _callbacks.add(callback);
  }

  @override
  void removeListener(void Function() callback) {
    if (_callbacks.contains(callback)) _callbacks.remove(callback);
  }

  void notifyCallbacks() {
    for (int i=0; i < _callbacks.length; i++) {
      _callbacks[i].call();
    }
  }
  
}