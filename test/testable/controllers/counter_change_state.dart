
import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/controllers/change_state.dart';

@visibleForTesting
class CounterChangeState extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallbacks();
  }

  void decrement() {
    counter--;
    notifyCallbacks();
  }
}