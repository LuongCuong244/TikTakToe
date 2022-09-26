// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.controller.dart';
import './cell.dart';

class GameFrame extends StatelessWidget {
  double frameSize;
  double space;

  GameFrame({super.key, required this.frameSize, required this.space});

  List<Cell> convert2DArray(list) {
    List<Cell> newList = [];
    int i, j;
    for (i = 0; i < list.length; i++) {
      for (j = 0; j < list[0].length; j++) {
        newList.add(list[i][j]);
      }
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: frameSize,
        height: frameSize,
        child: GridView.count(
          crossAxisSpacing: space,
          mainAxisSpacing: space,
          padding: EdgeInsets.fromLTRB(space, space, space, 0),
          crossAxisCount: 3,
          children: convert2DArray(context.watch<GameController>().cells),
        ),
      ),
    );
  }
}

// class GameFrame extends StatefulWidget {
//   double frameSize;
//   double space;
//   var cells = List.generate(3, (_) => []);

//   GameFrame(
//       {super.key,
//       required this.frameSize,
//       required this.space,
//       required this.cells});

//   @override
//   State<GameFrame> createState() => _GameFrameState();
// }

// class _GameFrameState extends State<GameFrame> {
//   // final double frameSize =
//   //     MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
//   // late final double space;
//   // List<Cell> cells = [];

//   // // ignore: non_constant_identifier_names
//   // _GameFrameState() {
//   //   space = frameSize * 0.03;
//   // }
//   List<Cell> convert2DArray(list) {
//     List<Cell> newList = [];
//     int i, j;
//     for (i = 0; i < list.length; i++) {
//       for (j = 0; j < list[0].length; j++) {
//         newList.add(list[i][j]);
//       }
//     }
//     return newList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: frameSize,
//       height: frameSize,
//       child: GridView.count(
//         crossAxisSpacing: space,
//         mainAxisSpacing: space,
//         padding:
//             EdgeInsets.fromLTRB(space, space, space, 0),
//         crossAxisCount: 3,
//         children: convert2DArray(cells),
//       ),
//     );
//   }
// }
