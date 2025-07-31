import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/controllers/stream_notifier_imp.dart';

class StreamNotifierBuilder<T> extends StatefulWidget {
  const StreamNotifierBuilder({super.key, required this.streamNotifier, required this.builder});

  final StreamNotifier<T> streamNotifier;
  final Widget Function(BuildContext context, T state) builder;

  @override
  State<StreamNotifierBuilder<T>> createState() => _StreamNotifierBuilderState<T>();
}

class _StreamNotifierBuilderState<T> extends State<StreamNotifierBuilder<T>> {
  late StreamSubscription<T>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription = widget.streamNotifier.stream.listen((newState) {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.streamNotifier.state);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}