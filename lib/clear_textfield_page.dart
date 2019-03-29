import 'package:flutter/material.dart';
import 'package:flutter_ui/widget/clear_textfield_widget.dart';

class ClearTextFieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClearTextFieldPageState();
  }
}

class _ClearTextFieldPageState extends State<ClearTextFieldPage> {
  TextEditingController controller;
  TextEditingController controller1;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller1 = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ClearTextField"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0)),
              child: ClearTextField(
                controller: controller,
                textStyle: TextStyle(color: Colors.black87, fontSize: 14),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入账号",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0)),
              child: ClearTextField(
                controller: controller1,
                obscureText: true,
                textStyle: TextStyle(color: Colors.black87, fontSize: 14),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入密码",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
