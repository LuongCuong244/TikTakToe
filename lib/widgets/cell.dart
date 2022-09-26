// ignore_for_file: library_private_types_in_public_api, must_be_immutable, non_constant_identifier_names
// ignore_for_file:invalid_use_of_protected_member
// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:tiktaktoe/value.painter.dart';
import 'dart:math';

class Cell extends StatefulWidget {
  double size;
  String value;
  int row, col;
  Function(int, int) indexCallBack;
  _CellState cellState = _CellState();

  Future<void> setValue(value) async {
    cellState.setState(() {
      this.value = value;
    });
    if (value == "X") {
      await cellState.lineOneDrawXOffsetController?.forward();
      await cellState.lineTwoDrawXOffsetController?.forward();
    } else if (value == "O") {
      await cellState.drawOController?.forward();
    }
  }

  resize(newSize) {
    cellState.setState(() {
      size = newSize;
    });
    cellState.initAnimationValue();
    if (value == "X") {
      // end values when animation has been ran
      cellState.lineOneDrawXOffset = Offset(newSize * (1 - cellState.ratio) / 2,
          newSize * (cellState.ratio + (1 - cellState.ratio) / 2));
      cellState.lineTwoDrawXOffset = Offset(
          newSize * (cellState.ratio + (1 - cellState.ratio) / 2),
          newSize * (cellState.ratio + (1 - cellState.ratio) / 2));
    }
  }

  resetForNewGame() {
    cellState.setState(() {
      value = "";
    });
    cellState.lineOneDrawXOffsetController?.reset();
    cellState.lineTwoDrawXOffsetController?.reset();
    cellState.drawOController?.reset();
    cellState.lineTwoDrawXOffset =
        const Offset(0.0, 0.0); // to prevent drawing the "lineTwoDrawXOffset"
  }

  Cell(
      {super.key,
      required this.size,
      this.value = "",
      required this.indexCallBack,
      required this.row,
      required this.col});

  @override
  State<Cell> createState() => cellState;
}

class _CellState extends State<Cell> with TickerProviderStateMixin {
  late Offset lineOneDrawXOffset = const Offset(0.0, 0.0);
  late Offset lineTwoDrawXOffset = const Offset(0.0, 0.0);
  late double sweepAngleDrawO = 0.0;
  final double ratio = 0.6;

  late Animation<Offset> lineOneDrawXOffset_Animation,
      lineTwoDrawXOffset_Animation;
  late Animation<double> sweepAngleDrawO_Animation;
  AnimationController? lineOneDrawXOffsetController,
      lineTwoDrawXOffsetController,
      drawOController;

  _CellState();

  @override
  void initState() {
    super.initState();
    setupAnimationControllers();
    initAnimationValue();
  }

  void setupAnimationControllers() {
    lineOneDrawXOffsetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    lineTwoDrawXOffsetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    drawOController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void initAnimationValue() {
    lineOneDrawXOffset_Animation = Tween(
      begin: Offset(widget.size * (ratio + (1 - ratio) / 2),
          widget.size * (1 - ratio) / 2),
      end: Offset(widget.size * (1 - ratio) / 2,
          widget.size * (ratio + (1 - ratio) / 2)),
    ).animate(lineOneDrawXOffsetController!)
      ..addListener(() {
        setState(() {
          lineOneDrawXOffset = lineOneDrawXOffset_Animation.value;
        });
      });

    lineTwoDrawXOffset_Animation = Tween(
      begin:
          Offset(widget.size * (1 - ratio) / 2, widget.size * (1 - ratio) / 2),
      end: Offset(widget.size * (ratio + (1 - ratio) / 2),
          widget.size * (ratio + (1 - ratio) / 2)),
    ).animate(lineTwoDrawXOffsetController!)
      ..addListener(() {
        setState(() {
          lineTwoDrawXOffset = lineTwoDrawXOffset_Animation.value;
        });
      });

    sweepAngleDrawO_Animation =
        Tween(begin: 0.0, end: 2 * pi).animate(drawOController!)
          ..addListener(() {
            setState(() {
              sweepAngleDrawO = sweepAngleDrawO_Animation.value;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.size * 0.15),
        color: const Color(0xFF181A18),
      ),
      child: TextButton(
        onPressed: () => widget.indexCallBack(widget.row, widget.col),
        style: TextButton.styleFrom(
          padding:
              EdgeInsets // three attributes to remove padding from TextButton
                  .zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: CustomPaint(
          painter: ValuePainter(widget.value, lineOneDrawXOffset,
              lineTwoDrawXOffset, sweepAngleDrawO),
          size: Size(widget.size, widget.size),
        ),
      ),
    );
  }
}
