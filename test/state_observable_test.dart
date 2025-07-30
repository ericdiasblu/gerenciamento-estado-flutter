import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciamento_estado/controllers/state_observable.dart';
import 'package:gerenciamento_estado/extensions/state_observable_extension.dart';

import 'testable/controllers/product_controller.dart';
import 'testable/entities/product_entity.dart';
import 'testable/states/base_state.dart';

void main() {
  group('Should test StateObservable', () {
    test('Should update state correctly when we increment counter', () {
      // Arrange
      final counterState = StateObservable(0);
      // Act
      counterState.state++;
      // Assert
      expect(counterState.state, 1);
    });

    test(
      'Should execute StateObservable callback when we increment counter',
      () {
        // Arrange
        bool isCallbackExecuted = false;
        final counterState = StateObservable(0);

        // Act
        void callback() {
          isCallbackExecuted = true;
        }

        counterState.addListener(callback);
        counterState.state++;

        // Assert
        expect(counterState.state, 1);

        expect(isCallbackExecuted, true);
      },
    );

    test('Should generate SuccessState when we call (getProducts)', () {
      // Arrange
      final ProductController productController = ProductController();
      expect(productController.state, isA<InitialState>());

      // Act
      productController.getProducts();

      // Assert
      expect(productController.state, isA<SuccessState>());
    });

    test('Should generate states in sequence', () {
      final ProductController productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<SuccessState<List<Product>>>(),
        ]),
      );
      productController.getProducts();
    });

    test('Should generate states in sequence when we get error', () {
      final ProductController productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<ErrorState>(),
        ]),
      );
      productController.generateError();
    });

    test('Should generate states in sequence when we have sucess and after get error', () {
      final ProductController productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<SuccessState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<ErrorState>(),
        ]),
      );
      productController.getProducts();

      productController.generateError();
    });

    test('TestingValueNotifier', () {
      // Arrange
      final valueNotifier = ValueNotifier(0);
      expect(valueNotifier.asStream(), emitsInOrder([0,1,2]));
      // Act
      valueNotifier.value++; // 1
      valueNotifier.value++; // 2
    });
  });
}
