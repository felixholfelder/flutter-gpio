import 'package:flutter/material.dart';
import 'package:rpi_gpio/gpio.dart';
import 'package:rpi_gpio/rpi_gpio.dart';

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
      home: const MyHomePage(title: 'RetroI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _ledState = false;
  late Gpio _gpio;
  late GpioOutput _led;

  @override
  void initState() {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () => toggleLed(),
                child: Text("${_ledState ? "Aus" : "An"}"))
          ],
        ),
      ),
    );
  }

  toggleLed() {
    print("toggle");
    print(_led);
    setState(() {
      _ledState = !_ledState;
      _led.value = _ledState;
    });
  }

  initGpio() async {
    _gpio = await initialize_RpiGpio();
    setState(() => _gpio);

    setState(() {
      _led = _gpio.output(14);
    });
  }
}
