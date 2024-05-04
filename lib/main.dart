import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
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
  bool _ledState = false;
  GPIO gpio = GPIO(14, GPIOdirection.gpioDirOut);
  GPIO soundControl = GPIO(2, GPIOdirection.gpioDirIn);

  @override
  void initState() {
    super.initState();

    GPIOreadEvent event = soundControl.readEvent();
    print(event.edge.name);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Retro.I"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: () => toggleLed(),
                  child: Text(_ledState ? "Aus" : "An"))
            ],
          ),
        ),
      ),
    );
  }

  toggleLed() {
    print("toggle");
    setState(() {
      _ledState = !_ledState;
      gpio.write(_ledState);
    });
  }
}
