import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volume_key_board/volume_key_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<String> _valueNotifier = ValueNotifier('press Volume key');
  int _num =0;
  @override
  void initState() {
    VolumeKeyBoard.instance.addListener((event) {
      if (event == VolumeKey.up) {
        _valueNotifier.value = "audioVolumeUp${_num++}";
      } else if (event == VolumeKey.down) {
        _valueNotifier.value = "audioVolumeDown${_num--}";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (BuildContext context, String value, Widget? child) {
              return Text(value);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    VolumeKeyBoard.instance.removeListener();
    super.dispose();
  }
}
