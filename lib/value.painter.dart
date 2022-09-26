// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class ValuePainter extends CustomPainter {
  late Paint _paint;
  String value = "";
  late Offset lineOneDrawXOffset = const Offset(0.0, 0.0);
  late Offset lineTwoDrawXOffset = const Offset(0.0, 0.0);
  late double sweepAngleDrawO = 0.0;
  final double ratio = 0.6;

  ValuePainter(this.value, this.lineOneDrawXOffset, this.lineTwoDrawXOffset,
      this.sweepAngleDrawO) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint.strokeWidth = size.width * 0.05;
    if (value == "X") {
      // draw X
      _paint.color = Colors.red;
      canvas.drawLine(
          Offset(size.width * (ratio + (1 - ratio) / 2),
              size.height * (1 - ratio) / 2),
          lineOneDrawXOffset,
          _paint);

      if (lineTwoDrawXOffset.dx != 0.0) {
        // 0.0 is default value
        canvas.drawLine(
            Offset(size.width * (1 - ratio) / 2, size.height * (1 - ratio) / 2),
            lineTwoDrawXOffset,
            _paint);
      }
    } else if (value == "O") {
      // draw O
      _paint.color = Colors.blue;
      _paint.style = PaintingStyle.stroke;
      canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width * ratio / 2),
          0,
          sweepAngleDrawO,
          false,
          _paint);
    } else if (value.isEmpty) {
      // remove
      _paint.color = const Color(0xFF181A18);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: size.width / 2,
              height: size.height / 2),
          _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
