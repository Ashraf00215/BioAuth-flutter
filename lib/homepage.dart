import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Container(
        child: Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
