import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
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
  final _sampleController = SampleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: FlareActor(
                'assets/flares/yuri_test1.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                controller: _sampleController,
                // animation: 'Untitled',
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ElevatedButton(
                child: Text('change'),
                onPressed: () => _change(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _change() {
    _sampleController.change();
  }
}

class SampleController extends FlareControls {
  bool idle = true;

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    play('Untitled');
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    Mat2D.invert(Mat2D(), viewTransform);
  }

  @override
  void onCompleted(String name) {
    print(name);
  }

  void change() {
    if (idle) {
      play('smile');
      idle = !idle;
      return;
    }

    play('idle');
    idle = !idle;
    return;
  }
}
