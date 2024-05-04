import 'package:flutter/material.dart';
import 'package:rpi_gpio/gpio.dart';
import 'package:rpi_gpio/rpi_gpio.dart';

void main() async {
  Gpio gpio = await initialize_RpiGpio();
  runApp(const MyApp(gpio: gpio));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.gpio});

  final Gpio gpio;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(gpio),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.gpio});

  final Gpio gpio;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _ledState = false;
  late GpioOutput _led;

  @override
  void initState() {
    super.initState();
    initGpio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Retro.I"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () => toggleLed(),
                child: Text(_ledState ? "Aus" : "An"))
          ],
        ),
      ),
    );
  }

  toggleLed() {
    print("toggle");
    try {
      setState(() {
        _ledState = !_ledState;
        _led.value = _ledState;
      });
    } catch (e) {
      print("Initialization not finished");
      print(e);
    }
  }

  initGpio() {
    setState(() {
      _led = widget.gpio.output(14)..value = false;
    });
    print("Initialization finished!");
  }
}
