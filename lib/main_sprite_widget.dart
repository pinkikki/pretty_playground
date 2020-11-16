import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';

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
  NodeWithSize rootNode;

  @override
  void initState() {
    super.initState();
    rootNode = NodeWithSize(const Size(1024, 1024));
    _load();
  }

  void _load() async {
    final images = ImageMap(rootBundle);

    await images.load(<String>[
      'assets/images/big_girl1.png',
      'assets/images/small_girl1.png',
      'assets/images/small_girl2.png',
      'assets/images/small_girl3.png',
      'assets/images/small_girl4.png',
    ]);

    final bigGirl = Sprite.fromImage(images['assets/images/big_girl1.png'])
      ..position = const Offset(500, 500)
      ..zPosition = 1
      ..size = const Size(100, 100);
    final smallGirl1 = Sprite.fromImage(images['assets/images/small_girl1.png'])
      ..position = const Offset(600, 600)
      ..zPosition = 1
      ..size = const Size(100, 100);
    final smallGirl2 = Sprite.fromImage(images['assets/images/small_girl2.png'])
      ..position = const Offset(600, 600)
      ..zPosition = 1
      ..visible = false
      ..size = const Size(100, 100);
    final smallGirl3 = Sprite.fromImage(images['assets/images/small_girl3.png'])
      ..position = const Offset(600, 600)
      ..zPosition = 1
      ..visible = false
      ..size = const Size(100, 100);
    final smallGirl4 = Sprite.fromImage(images['assets/images/small_girl4.png'])
      ..position = const Offset(600, 600)
      ..zPosition = 1
      ..visible = false
      ..size = const Size(100, 100);

    final node = Node();

    rootNode
      ..addChild(smallGirl1)
      ..addChild(smallGirl2)
      ..addChild(smallGirl3)
      ..addChild(smallGirl4)
      ..addChild(node)
      ..addChild(bigGirl);

    final myTween = MotionTween<Offset>((dynamic a) {
      bigGirl.position = a as Offset;
      if (600 < bigGirl.position.dx) {
        bigGirl.zPosition = 0;
      }
    }, const Offset(500, 500), const Offset(660, 660), 1);

    bigGirl.motions.run(myTween);

    final sequence = MotionSequence([
      MotionTween<double>((dynamic a) {
        smallGirl1.visible = true;
        smallGirl2.visible = false;
        smallGirl3.visible = false;
        smallGirl4.visible = false;
      }, 0, 1, 0.2),
      MotionTween<double>((dynamic a) {
        smallGirl1.visible = false;
        smallGirl2.visible = true;
        smallGirl3.visible = false;
        smallGirl4.visible = false;
      }, 0, 1, 0.2),
      MotionTween<double>((dynamic a) {
        smallGirl1.visible = false;
        smallGirl2.visible = false;
        smallGirl3.visible = true;
        smallGirl4.visible = false;
      }, 0, 1, 0.2),
      MotionTween<double>((dynamic a) {
        smallGirl1.visible = false;
        smallGirl2.visible = false;
        smallGirl3.visible = false;
        smallGirl4.visible = true;
      }, 0, 1, 0.2),
    ]);
    final forever = MotionRepeatForever(sequence);
    node.motions.run(sequence);
    node.motions.run(forever);
    node.motions.stop(forever);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SpriteWidget(rootNode),
    );
  }
}
