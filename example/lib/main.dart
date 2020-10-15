import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:safe_area_size/safe_area_size.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _navigationBarHeight = 0;
  int _statusBarHeight = 0;
  int _displayCutoutSize = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    int navigationBarHeight;
    int statusBarHeigth;
    int displayCutoutSize;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeigth = await SafeAreaSize.statusBarSize;
      navigationBarHeight = await SafeAreaSize.navigationBarSize;
      displayCutoutSize = await SafeAreaSize.displayCutoutSize;
    } on PlatformException {
      statusBarHeigth = 0;
      navigationBarHeight = 0;
      displayCutoutSize = 0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeigth;
      _navigationBarHeight = navigationBarHeight;
      _displayCutoutSize = displayCutoutSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
              child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text('Display Cutout: $_displayCutoutSize'),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Top: $_statusBarHeight'),
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Click me and then update!',
                  ),
                ),
                MaterialButton(
                  onPressed: () => initPlatformState(),
                  color: Colors.grey,
                  child: Center(
                    child: Text("Update"),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Bottom: $_navigationBarHeight'),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
