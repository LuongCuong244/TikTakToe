import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.controller.dart';

class GameDimensions extends ChangeNotifier {
  BuildContext context;
  double gameContainer = 350;
  double frameSize = 350;
  double cellSize = (350 - 4 * 350 * 0.03) / 3;
  double space = 350 * 0.03;

  GameDimensions(this.context);

  void setFrameSize(value) {
    frameSize = value;
    space = value * 0.03;
    cellSize = (value - 4 * space) / 3;
    context.read<GameController>().resizeAllCells(cellSize);
    notifyListeners();
  }
}
