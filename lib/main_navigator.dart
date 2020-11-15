import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final navigationKey = GlobalKey<NavigatorState>();
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigationKey,
      home: Navigator(
        pages: [
          MaterialPage(
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Container(
                  child: ElevatedButton(
                    child: Text('press'),
                    onPressed: () => _onPressed(0),
                  ),
                ),
              ),
            ),
          ),
          if (_index == 1 || _index == 2)
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text('1'),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text('press'),
                        onPressed: () => _onPressed(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_index == 2)
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Container(
                    child: Text('2'),
                  ),
                ),
              ),
            ),
        ],
        onPopPage: (route, result) {
          _index--;
          return route.didPop(result);
        },
      ),
    );
  }

  void _onPressed(int index) {
    setState(() {
      _index++;
    });
  }
}
