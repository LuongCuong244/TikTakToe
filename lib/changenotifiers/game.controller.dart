import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.dimensions.dart';
import '../screens/home.dart';
import '../widgets/cell.dart';
import '../screens/show.winner.dart';

class GameController extends ChangeNotifier {
  late BuildContext homeScreenContext;
  String label = "Player X's turn";
  bool turnX = true;
  bool gameOver = false;
  var cells = List.generate(3, (_) => []);

  GameController() {
    addCells();
  }

  void setHomeScreenContext(context) {
    homeScreenContext = context;
  }

  void addCells() {
    int i, j;
    for (i = 0; i < 3; i++) {
      for (j = 0; j < 3; j++) {
        cells[i].add(Cell(
          size: (350 - 350 * 0.03 * 4) / 3, // value default
          row: i,
          col: j,
          indexCallBack: clickOnCell,
        ));
      }
    }
  }

  void takeTurns() {
    label = "Player ${turnX ? "O" : "X"}'s turn";
    turnX = !turnX;
    notifyListeners();
  }

  void clickOnCell(int row, int col) {
    if (gameOver) {
      return;
    }
    if (cells[row][col].value.isEmpty) {
      if (turnX) {
        cells[row][col].setValue("X");
      } else {
        cells[row][col].setValue("O");
      }
      if (checkIfGameOver(row, col, turnX ? "X" : "O")) {
        gameOver = true;
        showWinnerScreen("Winner is ${turnX ? "X" : "O"}");
        label =
            "Player ${turnX ? "X" : "O"} has won the game. Let's reset for a new game.";
      } else {
        if (checkFrameHasFilled()) {
          gameOver = true;
          label = "The game is draw. Let's reset for a new game";
        } else {
          takeTurns();
        }
      }
    }
    notifyListeners();
  }

  bool checkFrameHasFilled() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (cells[i][j].value.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  bool checkIfGameOver(int row, int col, String value) {
    // chéo
    int i, count = 0;
    if (row == col) {
      for (int i = row - 2; i <= row + 2; i++) {
        if (i >= 0 && i <= 2 && cells[i][i].value == value) {
          count++;
        }
        if (count == 3) {
          return true;
        }
      }
    }
    count = 0;
    if (row + col == 2) {
      for (int i = -2; i <= 2; i++) {
        if (row + i >= 0 &&
            row + i <= 2 &&
            col - i >= 0 &&
            col - i <= 2 &&
            cells[row + i][col - i].value == value) {
          count++;
        }
        if (count == 3) {
          return true;
        }
      }
    }
    // dọc
    count = 0;
    for (int i = row - 2; i <= row + 2; i++) {
      if (i >= 0 && i <= 2 && cells[i][col].value == value) {
        count++;
      }
      if (count == 3) {
        return true;
      }
    }
    // ngang
    count = 0;
    for (int i = col - 2; i <= col + 2; i++) {
      if (i >= 0 && i <= 2 && cells[row][i].value == value) {
        count++;
      }
      if (count == 3) {
        return true;
      }
    }
    return false;
  }

  void setNewGame() {
    int i, j;
    for (i = 0; i < cells.length; i++) {
      for (j = 0; j < cells[i].length; j++) {
        if (cells[i][j].value.isNotEmpty) {
          cells[i][j].resetForNewGame();
        }
      }
    }
    label = "Player X's turn";
    turnX = true;
    gameOver = false;
    notifyListeners();
  }

  void resizeAllCells(value) {
    int i, j;
    for (i = 0; i < 3; i++) {
      for (j = 0; j < 3; j++) {
        cells[i][j].resize(value);
      }
    }
  }

  void showWinnerScreen(title) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.push(homeScreenContext,
          MaterialPageRoute(builder: ((context) => ShowWinner(title))));
    });
  }
}
