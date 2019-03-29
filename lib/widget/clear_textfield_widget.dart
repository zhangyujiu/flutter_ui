import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClearTextField extends StatefulWidget {
  TextStyle textStyle;
  InputDecoration decoration;
  TextEditingController controller;
  bool obscureText;
  TextInputType keyboardType;
  int maxLength;

  ClearTextField(
      {this.textStyle,
      this.decoration,
      @required this.controller,
      this.obscureText = false,
      this.maxLength,
      this.keyboardType = TextInputType.text});

  @override
  State<StatefulWidget> createState() {
    return _ClearTextFieldState();
  }
}

class _ClearTextFieldState extends State<ClearTextField> {
  bool isShow = false;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isShow = _focusNode.hasFocus && widget.controller.value.text.isNotEmpty;
      });
    });
    widget.controller.addListener(() {
      setState(() {
        isShow = _focusNode.hasFocus && widget.controller.value.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            style: widget.textStyle,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength==null?10000:widget.maxLength)
            ],
            decoration: widget.decoration,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText),
        Positioned(
          top: 1,
          bottom: 1,
          right: 10,
          child: Offstage(
            offstage: !isShow,
            child: GestureDetector(
              child: Image.asset(
                "assets/ic_edit_text_clear.png",
                width: 20,
                height: 20,
              ),
              onTap: () {
                widget.controller.text = "";
              },
            ),
          ),
        )
      ],
    );
  }
}
