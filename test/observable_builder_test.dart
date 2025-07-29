import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_estado/builders/observable_builder.dart';
import 'package:gerenciamento_estado/controllers/change_state.dart';

void main() {
  group('Should test ObservableBuilder', () {
    testWidgets('Should test increment Widget', (widgetsTests) async {
      await widgetsTests.pumpWidget(const MaterialApp(home: _CounterWidget()));
      final findText = find.text('Valor do Counter: 0');

      final findButton = find.byKey(const Key(buttonKey));

      expect(findText, findsOneWidget);

      expect(findButton, findsOneWidget);

      await widgetsTests.tap(findButton);
      await widgetsTests.pump();

      final nextCounterText = find.text('Valor do Counter: 1');

      expect(nextCounterText, findsOneWidget);
    });
  });
}

const buttonKey = "increment_key";

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({super.key});

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  final _counter = _ObservableCounter();

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
          child: const Text('Increment'),
          key: const Key(buttonKey),
        ),
      ],
    );
  }
}

class _ObservableCounter extends ChangeState {
  int count = 0;

  void increment() {
    count++;
    notifyCallbacks();
  }
}
