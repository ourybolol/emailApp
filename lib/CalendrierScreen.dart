import 'package:emailapp/AppDrawer.dart';
import 'package:flutter/material.dart';

class CalendrierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendrier"),
      ),
      drawer: AppDrawer(),
          body: Center(
        child:  Text("Calendrier"),
      ),
    );
  }
}