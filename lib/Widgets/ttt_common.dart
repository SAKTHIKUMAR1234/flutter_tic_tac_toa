import 'package:flutter/material.dart';
import '../Theme/mycustomtheme.dart';

class TttCommon extends StatefulWidget {
  final String? character;
  const TttCommon({super.key, this.character});

  @override
  State<StatefulWidget> createState() => _TttCommon();
}

class _TttCommon extends State<TttCommon> {
  @override
  Widget build(BuildContext context) {
    return widget.character != null? Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(), color: backgroudColor),
      child: LayoutBuilder(
        builder:
            (context, contraints) => Text(
              widget.character ?? '',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: (contraints.maxWidth - 60) > 25? (contraints.maxWidth - 60) : 25 ,
              ),
            ),
      )
    ) : SizedBox(height: 0,width: 0,);
  }
}
