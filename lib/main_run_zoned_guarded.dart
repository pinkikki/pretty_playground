import 'dart:async';

import 'package:flutter/material.dart';

final navigationKey = GlobalKey<NavigatorState>();

// https://pub.flutter-io.cn/packages/firebase_crashlytics/versions/0.2.0-dev.1/example

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App());
    },
    (dynamic error, StackTrace stackTrace) {
      showDialog(
        context: navigationKey.currentState.overlay.context,
        builder: (context) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.red),
          );
        },
      );
      print(
          'Caught error in my root zone. ${error.toString()}\n${stackTrace.toString()}');
    },
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
            child: Text('press raised button'),
            onPressed: () {
              throw Exception('error pressed raised button.');
            },
          ),
          ElevatedButton(
            child: Text('press elevated button'),
            onPressed: () {
              throw Exception('error pressed elevated button.');
            },
          ),
        ],
      )),
    );
  }
}
