import 'dart:async';

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:objectbox/observable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_playground/objectbox.g.dart';

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
  Store _store;
  Box _box;
  Query<Task> _query;
  final _streamController = StreamController<List<Task>>(sync: true);
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
    _store.close();
  }

  void _load() async {
    final dir = await getApplicationDocumentsDirectory();
    _store =
        Store(getObjectBoxModel(), directory: '${dir.path}/objectbox_sample');
    _box = Box<Task>(_store);
    // final Query<Task> query = _box.query(Task_.name.equals('task1')).build();
    _query = _box.query().build();
    var all = _query.find();
    _streamController.add(all);
    _streamController.addStream(_query.findStream());
    setState(() {
      _count = all.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: StreamBuilder<List<Task>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading...');
                  case ConnectionState.none:
                    break;
                  case ConnectionState.active:
                    final querySnapshot = snapshot.data;
                    return Flexible(
                      child: ListView.builder(
                        itemCount: querySnapshot.length,
                        itemBuilder: (context, index) =>
                            Text(querySnapshot[index].name),
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    break;
                }
                return Container();
              },
            ),
          ),
          Container(
            child: ElevatedButton(
                child: Text('add'),
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                  _box.put(
                    Task()
                      ..id = _count
                      ..name = 'Task$_count',
                  );
                }),
          ),
        ],
      ),
    );
  }
}

@Entity()
class Task {
  @Id()
  int id;
  String name;
}
