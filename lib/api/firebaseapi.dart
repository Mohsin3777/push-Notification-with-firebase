import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

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
