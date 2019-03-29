import 'package:flutter/material.dart';

class SlideIndicator extends StatefulWidget {
  int count = 0;
  double spacing;
  double radius;
  PageController controller;
  Color normalColor;
  Color selectColor;

  SlideIndicator(
      {@required this.count,
      this.spacing = 8,
      this.radius = 4,
      @required this.controller,
      this.normalColor = Colors.grey,
      this.selectColor = Colors.red})
      : assert(count > 0);

  @override
  State<StatefulWidget> createState() {
    return _SlideIndicatorState();
  }
}

class _SlideIndicatorState extends State<SlideIndicator> {
  double offset = 0;
  double width;
  double totalWidth;

  @override
  void initState() {
    super.initState();
    width = widget.radius * 2 * widget.count +
        widget.spacing * (widget.count - 1) -
        widget.radius * 2;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    totalWidth = MediaQuery.of(context).size.width * (widget.count - 1);
    widget.controller.addListener(() {
      offset = widget.controller.offset * width / totalWidth;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, 50),
      painter: SlideIndicatorPainter(
          count: widget.count,
          spacing: widget.spacing,
          radius: widget.radius,
          offset: offset,
          normalColor: widget.normalColor,
          selectColor: widget.selectColor),
    );
  }
}

class SlideIndicatorPainter extends CustomPainter {
  int count = 0;
  double spacing;
  double radius;
  double offset;
  Color normalColor;
  Color selectColor;

  SlideIndicatorPainter(
      {this.count,
      this.spacing,
      this.radius,
      this.offset = 0,
      this.normalColor,
      this.selectColor});

  @override
  void paint(Canvas canvas, Size size) {
    var buttonPointPainter = Paint()
      ..isAntiAlias = true
//      ..strokeWidth = 10
      ..color = normalColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    var slidePointPainter = Paint()
      ..isAntiAlias = true
//      ..strokeWidth = 10
      ..color = selectColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < count; i++) {
      canvas.drawCircle(
          Offset(radius + (radius * 2 + spacing) * i, size.height / 2),
          radius,
          buttonPointPainter);
    }
    canvas.drawCircle(
        Offset(radius + offset, size.height / 2), radius, slidePointPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
