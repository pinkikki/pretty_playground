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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text('press'),
          onPressed: () => _showModalPicker(context),
        ),
      ),
    );
  }

  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    children: List<Widget>.generate(
                        10, (index) => _pickerItem(index)),
                    onSelectedItemChanged: _onSelectedItemChanged,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    children: List<Widget>.generate(
                        10, (index) => _pickerItem(index)),
                    onSelectedItemChanged: _onSelectedItemChanged,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pickerItem(int index) {
    return Text(
      index.toString(),
      style: const TextStyle(fontSize: 32),
    );
  }

  void _onSelectedItemChanged(int index) {
    print(index);
  }
}
