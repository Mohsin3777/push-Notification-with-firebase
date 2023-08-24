import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PracticeNotification extends StatefulWidget {
  const PracticeNotification({super.key});

  @override
  State<PracticeNotification> createState() => _PracticeNotificationState();
}

class _PracticeNotificationState extends State<PracticeNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initize() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (payload) {}
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            const AndroidNotificationDetails androidNotificationDetails =
                AndroidNotificationDetails(
                    'your channel id', 'your channel name',
                    channelDescription: 'your channel description',
                    importance: Importance.max,
                    priority: Priority.high,
                    ticker: 'ticker');
            const NotificationDetails notificationDetails =
                NotificationDetails(android: androidNotificationDetails);
            await flutterLocalNotificationsPlugin.show(
                0, 'plain title', 'plain body', notificationDetails,
                payload: 'item x');
          },
          child: Text('ELEVATED BUTON'),
        ),
      ),
    );
  }
}
