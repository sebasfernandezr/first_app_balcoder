import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Home page")),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("hola");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
