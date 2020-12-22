import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool _isNext = false;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.yellow,
        child: Stack(
          children: [
            Center(
              child: ElevatedButton(
                child: Text('next'),
                onPressed: () {
                  setState(() {
                    _isNext = true;
                  });
                },
              ),
            ),
            Visibility(
              visible: _isNext,
              maintainState: true,
              maintainAnimation: true,
              child: AnimatedOpacity(
                opacity: _isNext ? 1 : 0,
                duration: Duration(milliseconds: 500),
                onEnd: () async {
                  if (_isNext) {
                    await Navigator.of(context).push(
                      FadeoutTransition(
                        page: NextPage(),
                        settings: RouteSettings(
                          name: '/next',
                        ),
                      ),
                    );
                  }
                  setState(() {
                    _isNext = false;
                  });
                },
                child: Container(
                  color: Colors.white,
                  width: mediaSize.width,
                  height: mediaSize.height,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        width: mediaSize.width,
        height: mediaSize.height,
        child: Text('test'),
      ),
    );
  }
}

class FadeoutTransition<T> extends PageRouteBuilder<T> {
  final Widget page;
  final RouteSettings settings;

  FadeoutTransition({this.page, this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget page,
          ) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: page,
            );
          },
          transitionDuration: Duration(milliseconds: 1000),
        );
}
