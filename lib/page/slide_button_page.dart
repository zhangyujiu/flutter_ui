import 'package:flutter/material.dart';
import 'package:flutter_ui/widget/slide_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SlideButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideButtonPageState();
  }
}
class _SlideButtonPageState extends State<SlideButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlideButton"),
      ),
      body: ListView(
        children: getSlides(),
      ),
    );
  }

  List<SlideButton> list;

  List<SlideButton> getSlides() {
    list = List<SlideButton>();
    for (var i = 0; i < 10; i++) {
      var key = GlobalKey<SlideButtonState>();
      var slide = SlideButton(
        key: key,
        singleButtonWidth: 80,
        onSlideStarted: (){
          list.forEach((slide){
            if(slide.key!=key){
              slide.key.currentState?.close();
            }
          });
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text("测试测试测试测试测试测试测试测试"),
          ),
        ),
        buttons: <Widget>[
          buildAction(key, "置顶", Colors.grey[400], () {
            Fluttertoast.showToast(msg: "置顶");
            key.currentState.close();
          }),
          buildAction(key, "标为未读", Colors.amber, () {
            Fluttertoast.showToast(msg: "标为未读");
            key.currentState.close();
          }),
          buildAction(key, "删除", Colors.red, () {
            Fluttertoast.showToast(msg: "删除");
            key.currentState.close();
          }),
        ],
      );
      list.add(slide);
    }
    return list;
  }

  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {

    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        color: color,
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}