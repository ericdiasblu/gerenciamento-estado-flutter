import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/builders/stream_notifier_builder.dart';
import 'package:gerenciamento_estado/controllers/stream_notifier_imp.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  final _counterNotifier = StreamNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciamento de Estado')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamNotifierBuilder(
              listen: (context, state) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Valor emitido: $state')),
                );
              },
              streamNotifier: _counterNotifier,
              builder: (context, state) {
                return Text('Valor do Counter: ${_counterNotifier.state}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                _counterNotifier.emit(_counterNotifier.state + 1);
              },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
