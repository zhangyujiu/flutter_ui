import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);

class ArcProgressBar extends StatefulWidget {
  ProgressController controller;
  double radius;
  double maxProgress;
  double initProgress;
  double value;

  Color ringColor;
  Color progressColor;
  double strokeWidth;

  ArcProgressBar(
      {@required this.radius,
      @required this.maxProgress,
      double initProgress,
      @required this.controller,
      this.ringColor = Colors.blue,
      this.progressColor = Colors.red,
      this.strokeWidth = 10})
      : initProgress = initProgress == null ? 0 : initProgress,
        assert(initProgress <= maxProgress);

  @override
  State<StatefulWidget> createState() {
    return _ArcProgressBarState();
  }
}

class _ArcProgressBarState extends State<ArcProgressBar>
    with SingleTickerProviderStateMixin {
  double progressAngel;

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        upperBound: widget.maxProgress,
        duration: Duration(seconds: 2),
        vsync: this)
      ..addListener(() {
        var value = _animationController.value;
        setState(() {
          progressAngel = (270 * value) / widget.maxProgress;
        });
      });

    widget.controller.listener.addListener(() {
      double value = widget.controller.listener.value;
      value = value >= widget.maxProgress ? widget.maxProgress : value;
      _animationController.value = value;
      widget.value = value;
    });
    widget.controller.changeProgress(widget.initProgress);
    widget.value = widget.initProgress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: ArcPainter(
            strokeWidth: widget.strokeWidth,
            ringColor: widget.ringColor,
            progressColor: widget.progressColor,
            progressAngel: progressAngel,
            value: widget.value),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

class ArcPainter extends CustomPainter {
  double degreeAngel = 270;
  double progressAngel = 0;
  double value;
  Color ringColor;
  Color progressColor;
  double strokeWidth;

  ArcPainter(
      {progressAngel,
      value,
      this.ringColor = Colors.blue,
      this.progressColor = Colors.red,
      this.strokeWidth = 10})
      : progressAngel = progressAngel == null ? 0 : progressAngel,
        value = value == null ? 0 : value;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
//    canvas
//      ..translate(size.width/2  + size.width /2 /sin(degToRad(45)),
//          size.height * cos(45));
//    canvas.rotate(degToRad(135));
    translateAndRotateCanvas(canvas,size,135);
    //绘制底部圆环
    var bigPainter = Paint()
      ..strokeWidth = strokeWidth
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var progressPainter = Paint()
      ..strokeWidth = strokeWidth
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2 - strokeWidth / 2),
        0,
        degToRad(degreeAngel),
        false,
        bigPainter);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2 - strokeWidth / 2),
        0,
        degToRad(progressAngel),
        false,
        progressPainter);
    canvas.restore();

    //绘制文字
    ParagraphBuilder pb =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.center))
          ..pushStyle(ui.TextStyle(color: Color(0xff333333), fontSize: 20))
          ..addText(value.toInt().toString());
    ParagraphConstraints pc = ParagraphConstraints(width: size.width);
    Paragraph paragraph = pb.build()..layout(pc);
    print(paragraph.minIntrinsicWidth);
    canvas.drawParagraph(
        paragraph, Offset(0, size.height / 2 - paragraph.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void translateAndRotateCanvas(Canvas canvas,Size size,double degAngel){
  // 计算画布中心轨迹圆半径
    double r = sqrt(pow(size.width, 2) + pow(size.height, 2));
  // 计算画布中心点初始弧度
    double startAngle = atan(size.height / size.width);
  // 计算画布初始中心点坐标
    Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
  // 需要旋转的弧度
    double xAngle=degToRad(135);
  // 计算旋转后的画布中心点坐标
    Point px = Point(
        r * cos(xAngle + startAngle), r * sin(xAngle + startAngle));
  // 先平移画布
    canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
  // 后旋转
    canvas.rotate(xAngle);

  }
}

class ProgressController {
  ValueNotifier<double> listener = ValueNotifier(0);

  get value => listener.value;

  void changeProgress(double progress) {
    listener.value = progress;
  }
}
