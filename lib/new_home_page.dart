
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pushh_notifcation/new_notification_class/firebase_class.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('NEW CLASS PRACTICE'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Center(
  child: TextButton(child: Text('PRESS'),onPressed: (){
firebaseNewClass.getDeviceToken().then((value)async {
  var data ={
    'to':value.toString(),
    'priority': 'high',
    'notification':{
      'title':'Asif',
      'body':'Subscribe to my channel'
    },
    'data':{
        'chat': 'message',
      'id': '1234567'
    }
  };
await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
body: jsonEncode(data),
headers: {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization' :'key=AAAAbP61VcY:APA91bHJL3pj8MeTkAXmHHb342o9wWH77JfWqSxYyNxq_VFz9sgvdpx5o7vxzXCSwVk21TEwFwqakYV4GNO5LqfzWYKgBbKYYdUqclo9fM6ibKHJb8ZOTeZ49cFzdDB4eqHQcgib1KUP'
}
);
});
  },),
)
        ],
      ),
    );
  }
}