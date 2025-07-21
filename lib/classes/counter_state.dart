import 'package:gerenciamento_estado/controllers/change_state.dart';

class CounterState extends ChangeState{
  int counter = 0;
  
  void increment() {
    counter++;
    notifyCallbacks();
  }
}