import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pushh_notifcation/dummy_chat_screen.dart';

class FirebaseNewClass{

   final _firebaseMessaging = FirebaseMessaging.instance;
  


  //to get permission from device
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

//get device token
  Future<String> getDeviceToken()async{
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }
//check token is expire or not
 isTokenRefresh()async{
   _firebaseMessaging.onTokenRefresh.listen((event) { 
    event.toString();
   });
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

   //initilize notification
 void initNotification(BuildContext context , RemoteMessage message)async{
   var androidInitilizationSettings =const AndroidInitializationSettings('@mipmap/ic_launcher');

   var iOsInitilizationSettings =const  IOSInitializationSettings();

   var initializationSettings = InitializationSettings(
       android: androidInitilizationSettings,
       iOS: iOsInitilizationSettings

   );
   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
   onSelectNotification:(payload){
    handleMessage(context ,message);
   }
   );
 }

  void firebaseInit(BuildContext context){
     FirebaseMessaging.onMessage.listen((message) {
       if (kDebugMode) {
         print(message.notification!.title.toString());
          print(message.notification!.body.toString());
           print(message.data.toString());
             print(message.data['chat'].toString());
               print(message.data['id'].toString());

       }
      
      if(Platform.isAndroid){
        initNotification(context, message);
showNotification(message);
      }else{
        showNotification(message);
      }


     });
  }

  Future<void> showNotification(RemoteMessage message)async{

   AndroidNotificationChannel channel =AndroidNotificationChannel(
       Random.secure().nextInt(10000).toString()

   , 'High Importance',
   importance: Importance.max
   );
   
   AndroidNotificationDetails androidNotificationDetails =AndroidNotificationDetails(
      channel.id ,
     channel.name,
     channelDescription: 'Your Channel Descriptions',
     importance: Importance.high,
     priority: Priority.high,
     ticker: 'ticker'

   );
   NotificationDetails notificationDetails =NotificationDetails(
     android: androidNotificationDetails
   );
   
   Future.delayed(Duration.zero ,(){
     flutterLocalNotificationsPlugin.show(0, message.notification!.title.toString(),
         message.notification!.body.toString(),
         notificationDetails);
   });



  }


  void handleMessage(BuildContext context , RemoteMessage message){
    
    if(message.data['chat']=='message')
Navigator.push(context, MaterialPageRoute(builder: (context)=> DummyChatScreen(id: message.data['id'],)));
  }

  //when app in background
  Future<void> setupInteractMessage(BuildContext context )async{
    //whem app is terminated
    RemoteMessage? initialMessage  = await  FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) { 
      handleMessage(context, event);
    });
  }



}