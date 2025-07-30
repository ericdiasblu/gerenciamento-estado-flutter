import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/classes/counter_state.dart';
import 'package:gerenciamento_estado/controllers/state_observable.dart';
import 'package:gerenciamento_estado/mixins/change_state_mixin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
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

class _MyHomePageState extends State<MyHomePage> with ChangeStateMixin {
  final observableCounter = StateObservable(0);
  final counterState = CounterState();
  late StateObservable<int> newMixinCounter;

  @override
  initState() {
    useChangeState(observableCounter);
    useChangeState(counterState);
    newMixinCounter = useStateObservable(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciamento de Estado"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor do CounterState: ${counterState.counter}'),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: const Text('Incrementar'),
            ),
            Text('Valor do ObservableCounter: ${observableCounter.state}'),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: const Text('Incrementar'),
            ),
            Text('Valor do newMixinCounter: ${newMixinCounter.state}'),
            ElevatedButton(
              onPressed: () {
                newMixinCounter.state++;
              },
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
