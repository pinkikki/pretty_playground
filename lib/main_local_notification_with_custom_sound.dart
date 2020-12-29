import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    super.initState();
    _initializeLocalNotification();
  }

  Future<void> _initializeLocalNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'sample id', 'sample name', 'sample description',
        importance: Importance.max, priority: Priority.high);
    final iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'aruco_strong_with_notification.caf',
      presentSound: true,
    );
    platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  Future<void> _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print('id=[$id]. title=[$title]. body=[$body]. payload=[$payload]');
  }

  Future<void> _onSelectNotification(String payload) async {
    print(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('push notification'),
              onPressed: () async {
                await flutterLocalNotificationsPlugin.show(
                    0, 'sample title', 'sample body', platformChannelSpecifics,
                    payload: 'sample id');
              },
            ),
          ],
        ),
      ),
    );
  }
}
