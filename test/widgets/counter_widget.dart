import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/builders/observable_builder.dart';

import '../testable/controllers/observable_counter.dart';
import '../observable_builder_test.dart';

@visibleForTesting
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final _counter = ObservableCounter();
  @visibleForTesting
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ObservableBuilder(
          observable: _counter,
          builder: (context, child) {
            return Text('Valor do Counter: ${_counter.count}');
          },
        ),
        ElevatedButton(
          onPressed: () {
            _counter.increment();
          },
          key: const Key(buttonKey),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
