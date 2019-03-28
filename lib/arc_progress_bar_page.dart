import 'package:flutter/material.dart';
import 'package:flutter_ui/widget/arc_progress_bar.dart';

class ArcProgressBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArcProgressBarPageState();
  }
}

class _ArcProgressBarPageState extends State<ArcProgressBarPage> {
  ProgressController controller;

  @override
  void initState() {
    super.initState();
    controller = ProgressController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ArcProgressBar"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: ArcProgressBar(
              radius: 80,
              maxProgress: 1000,
              initProgress: 80,
              controller: controller,
              ringColor: Colors.blue,
              progressColor: Colors.red,
            ),
          ),
          RaisedButton(
            onPressed: () {
              controller.changeProgress(controller.value + 80);
            },
            child: Text("Add"),
          ),
          RaisedButton(
            onPressed: () {
              controller.changeProgress(0);
            },
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }
}
