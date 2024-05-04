import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dart_periphery/dart_periphery.dart';

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
  // late Gpio _gpio;
  // late GpioOutput _led;

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
    // print("toggle");
    // try {
    //   setState(() {
    //     _ledState = !_ledState;
    //     _led.value = _ledState;
    //   });
    // } catch (e) {
    //   print("Initialization not finished");
    //   print(e);
    // }
  }

  initGpio() async {
    // _gpio = await initialize_RpiGpio();
    // setState(() {
    //   _gpio;
    //   _led = _gpio.output(14)..value = false;
    // });
    // print("Initialization finished!");


    var config = GPIOconfig.defaultValues();
    config.direction = GPIOdirection.gpioDirOut;
    print('Native c-periphery Version :  ${getCperipheryVersion()}');
    print('GPIO test');
    var gpio = GPIO(14, GPIOdirection.gpioDirOut);

    print('GPIO info: ${gpio.getGPIOinfo()}');

    print('GPIO native file handle: ${gpio.getGPIOfd()}');
    print('GPIO chip name: ${gpio.getGPIOchipName()}');
    print('GPIO chip label: ${gpio.getGPIOchipLabel()}');
    print('GPIO chip name: ${gpio.getGPIOchipName()}');
    print('CPIO chip label: ${gpio.getGPIOchipLabel()}');

    for (var i = 0; i < 10; ++i) {
      gpio.write(true);
      sleep(Duration(milliseconds: 200));
      gpio.write(false);
      sleep(Duration(milliseconds: 200));
    }

    gpio.dispose();
  }
}
