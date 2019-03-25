import 'package:flutter/material.dart';
import 'package:flutter_ui/arc_progress_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ProgressController controller = ProgressController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                child: ArcProgressBar(
                  controller: controller,
                  radius: 80,
                  initProgress: 20,
                  maxProgress: 100,
                ),
                alignment: Alignment.center,
              ),
              RaisedButton(
                onPressed: () {
                  var angel = controller.value + 8;
                  controller.changeProgress(angel);
                },
                child: Text("测试"),
              ),
              RaisedButton(
                onPressed: () {
                  controller.changeProgress(0);
                },
                child: Text("reset"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
