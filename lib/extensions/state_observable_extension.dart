import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/controllers/state_observable.dart';

@visibleForTesting
extension ObservableStream<T> on StateObservable<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();
    streamController.add(state); // InitialState

    void callback() {
      streamController.add(state); // Loading  -> SuccessState
    }

    addListener(callback);

    return streamController.stream;
  }
}

@visibleForTesting
extension ObservableValueNotifier<T> on ValueNotifier<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(value);

    void callback() {
      streamController.add(value);
    }

    addListener(callback);

    return streamController.stream;
  }
}

// Reatividade de primitivos

// int
extension ReactiveInt on int {
  /// Cria uma instância de [StateObservable] para o tipo [int].
  ///
  /// Retorna um [StateObservable<int>].
  StateObservable<int> obs() => StateObservable(this);
}

// double
extension ReactiveDouble on double {
  StateObservable<double> obs() => StateObservable(this);
}

// string
extension ReactiveString on String {
  StateObservable<String> obs() => StateObservable(this);
}

// bool
extension ReactiveBool on bool {
  StateObservable<bool> obs() => StateObservable(this);
}