import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widgets/counter_widget.dart';

void main() {
  group('Should test ObservableBuilder', () {
    testWidgets('Should test increment Widget', (widgetsTests) async {
      await widgetsTests.pumpWidget(const MaterialApp(home: CounterWidget()));
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

