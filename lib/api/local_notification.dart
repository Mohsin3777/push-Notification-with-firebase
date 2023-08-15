import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android Notification Settings
  final AndroidNotificationDetails _androidPlatformChannelSpecifics =
      const AndroidNotificationDetails('001', 'Prac1',
          channelDescription: "Prac1",
          importance: Importance.max,
          priority: Priority.high);

  // iOS Notification Settings

  // final IOSNotificationDetails _iosNotificationDetails =
  //     const IOSNotificationDetails(
  //         presentAlert: true, presentBadge: true, presentSound: true);

  // Initialize
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: true,
    //   requestBadgePermission: true,
    //   requestAlertPermission: true,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS
    );

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNootification: selectNotification
    );
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) {}

  // Handle notification selection deep linking
  Future<void> selectNotification(String? payload) async {
    //Handle notification tapped logic here
    print("Notification payload: $payload");
  }

  void showNotification(String? title, String? body) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: _androidPlatformChannelSpecifics,
      // iOS: _iosNotificationDetails
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }
}
