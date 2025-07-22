import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/builders/observable_builder.dart';
import 'package:gerenciamento_estado/builders/observable_state_builder.dart';
import 'package:gerenciamento_estado/classes/counter_state.dart';
import 'package:gerenciamento_estado/controllers/state_observable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final observableCounter = StateObservable(0);
  final counterState = CounterState();

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciamento de Estado")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObservableStateBuilder(
              stateObservable: observableCounter,
              listener: (context, state) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Valor do CounterState: $state')),
                );
              },
              buildWhen: (oldState, newState) {
                return newState % 2 == 0;
              },
              builder: (context, state, child) {
                return Text('Valor do CounterState: $state');
              },
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
