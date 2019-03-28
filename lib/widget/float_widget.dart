import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FloatWidget extends StatefulWidget {
  Widget child;
  FloatButton button;
  bool isHasTitlebar;

  FloatWidget(
      {@required this.child,
      @required this.button,
      this.isHasTitlebar = false});

  @override
  State<StatefulWidget> createState() {
    return _FloatWidgetState();
  }
}

class _FloatWidgetState extends State<FloatWidget> {
  final Map<Type, GestureRecognizerFactory> gestures =
      <Type, GestureRecognizerFactory>{};
  double translateY = 300;
  double maxSlideHeight = 0;

  @override
  void initState() {
    super.initState();
    gestures[VerticalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(debugOwner: this),
      (VerticalDragGestureRecognizer instance) {
        instance
          ..onDown = onVerticalDragDown
          ..onUpdate = onVerticalDragUpdate
          ..onEnd = onVerticalDragEnd;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    translateY=MediaQuery.of(context).size.height/3;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          widget.child,
          Positioned(
            child: RawGestureDetector(
              gestures: gestures,
              child: widget.button,
            ),
            right: 0,
            top: translateY,
          )
        ],
      ),
    );
  }

  void onVerticalDragDown(DragDownDetails details) {}

  void onVerticalDragUpdate(DragUpdateDetails details) {
    maxSlideHeight = widget.isHasTitlebar
        ? MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            56 -
            widget.button.size.height
        : MediaQuery.of(context).size.height -
            widget.button.size.height;
    var dy = details.delta.dy;
    translateY = translateY + dy;
    if (translateY < 0) {
      translateY = 0;
    } else if (translateY > maxSlideHeight) {
      print(MediaQuery.of(context).padding.top);
      translateY = maxSlideHeight;
    }

    setState(() {});
  }

  void onVerticalDragEnd(DragEndDetails details) {}
}

class FloatButton extends StatefulWidget {
  Widget button;
  GlobalKey<FloatButtonState> key;
  Size size;

  FloatButton({@required this.key, @required this.button, @required this.size})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FloatButtonState();
  }
}

class FloatButtonState extends State<FloatButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: widget.button,
    );
  }
}
