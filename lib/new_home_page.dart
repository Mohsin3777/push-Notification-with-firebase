
import 'package:flutter/material.dart';
import 'package:pushh_notifcation/new_notification_class/firebase_class.dart';

class NEWHOMEPAGE extends StatefulWidget {
  const NEWHOMEPAGE({super.key});

  @override
  State<NEWHOMEPAGE> createState() => _NEWHOMEPAGEState();
}

class _NEWHOMEPAGEState extends State<NEWHOMEPAGE> {

FirebaseNewClass firebaseNewClass =FirebaseNewClass();
  @override
  void initState() {
       firebaseNewClass.requestPermission();
    // TODO: implement initState
    super.initState();
// firebaseNewClass.isTokenRefresh();
firebaseNewClass.firebaseInit(context);
firebaseNewClass.setupInteractMessage(context);
    firebaseNewClass.getDeviceToken().then((value) {
      print('Device token');
      print(value);
    });
 
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(title: Text('NEW CLASS PRACTICE'),),
      body: Column(
        children: [

        ],
      ),
    );
  }
}