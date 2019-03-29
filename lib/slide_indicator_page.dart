import 'package:flutter/material.dart';
import 'package:flutter_ui/widget/slide_indicator.dart';

class SlideIndicatorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideIndicatorPageState();
  }
}

class _SlideIndicatorPageState extends State<SlideIndicatorPage> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlideIndicator"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _controller,
              children: <Widget>[
                Image.asset("assets/flash.jpg",fit: BoxFit.fill,),
                Image.asset("assets/flash.jpg",fit: BoxFit.fill,),
                Image.asset("assets/flash.jpg",fit: BoxFit.fill,),
                Image.asset("assets/flash.jpg",fit: BoxFit.fill,),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10),
              child: SlideIndicator(
                count: 4,
                controller: _controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
