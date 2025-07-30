import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/controllers/change_state.dart';

@visibleForTesting
class ObservableCounter extends ChangeState {
  int count = 0;

  void increment() {
    count++;
    notifyCallbacks();
  }
}