import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pushh_notifcation/api/local_notification.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitilization =
        AndroidInitializationSettings('@mipmp/ic_launcher');
    // var iosInitilization = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitilization,
      // iOS: iosInitilization,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: (payload) {}
    );
  }

  Future<void> initNotifications() async {
    // await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   announcement: true,
    //   badge: true,
    //   carPlay: true,
    //   criticalAlert: true,
    //   provisional: true,
    //   sound: true,
    // );
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM NOtification ' + fCMToken.toString());
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());

        NotificationService notificationService = NotificationService();
        notificationService.showNotification(
            message.notification!.title.toString(),
            message.notification!.body.toString());
      }

      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'High important notification',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your Channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    //for ios
    // const DarwinNotificationDetails darwinNotificationDetails =
    //     DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      //  iOS: darwinNotificationDetails
    );
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          2,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  getDeviceToken() async {
    final fCMToken = await _firebaseMessaging.getToken();
    return fCMToken;
  }

  isTokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User grented permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User grented provisional permission');
    } else {
      print('User not grented permission');
    }
  }
}
