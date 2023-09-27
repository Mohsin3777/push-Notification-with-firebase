import 'package:flutter/material.dart';

class DummyChatScreen extends StatefulWidget {
  final String id;
  const DummyChatScreen({super.key, required this.id});

  @override
  State<DummyChatScreen> createState() => _DummyChatScreenState();
}

class _DummyChatScreenState extends State<DummyChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Dummy Chat Screen'+widget.id),),
    );
  }
}