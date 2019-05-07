import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/page/arc_progress_bar_page.dart';
import 'package:flutter_ui/page/clear_textfield_page.dart';
import 'package:flutter_ui/page/popup_page.dart';
import 'package:flutter_ui/page/slide_button_page.dart';
import 'package:flutter_ui/page/slide_indicator_page.dart';
import 'package:flutter_ui/widget/popup_window.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

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
            getItem(context, "侧滑删除", SlideButtonPage()),
            getItem(context, "进度条", ArcProgressBarPage()),
            getItem(context, "PageView指示器", SlideIndicatorPage()),
            getItem(context, "ClearTextField", ClearTextFieldPage()),
            getItem(context, "PopupPage", PopupPage()),
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
