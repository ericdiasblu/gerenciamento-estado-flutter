import 'package:flutter/material.dart';
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

  initState() {
    counterState.addListener(callback);
    observableCounter.addListener(callback);
    super.initState();
  }

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
            Text("Valor de estado do ChangeState: ${counterState.counter}"),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text("Incrementar"),
            ),
            Text("Valor de estado do StateObservable: ${observableCounter.state}"),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text("Incrementar"),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    counterState.removeListener(callback);
    observableCounter.removeListener(callback);
    super.dispose();
  }
}
