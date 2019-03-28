import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/arc_progress_bar_page.dart';
import 'package:flutter_ui/slide_button_page.dart';
import 'package:flutter_ui/widget/float_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter UI"),
        ),
        body: ListView(
          children: <Widget>[
            getItem(context, "SlideButton", SlideButtonPage()),
            getItem(context, "ArcProgress", ArcProgressBarPage())
          ],
        ));
  }

  ListTile getItem(BuildContext context, String title, Widget widget) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => widget));
      },
    );
  }
}
