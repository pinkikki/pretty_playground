import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String rawCookie = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('get cookie'),
              onPressed: () async {
                final response = await http.get('https://www.google.com/');
                // 複数存在する場合も、Stringで返却されてしまう
                final cookies = response.headers[HttpHeaders.setCookieHeader];
                setState(() {
                  rawCookie = cookies;
                });
              },
            ),
          ),
          Container(
            child: Text(rawCookie),
          )
        ],
      ),
    );
  }
}
