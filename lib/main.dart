import 'package:flutter/material.dart';
import 'package:quik_employer/service/authentication.dart';
import 'package:quik_employer/ui/root_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Returning Data',

        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepPurpleAccent,
          //Changing this will change the color of the TabBar
          accentColor: Colors.deepPurple,
        ),
        //home: HomeOpen(),);
        home: new RootPage(auth: new Auth()));

  }
}