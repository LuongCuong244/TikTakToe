import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.controller.dart';
import 'package:tiktaktoe/screens/home.dart';
import 'package:tiktaktoe/widgets/button.dart';

class ShowWinner extends StatelessWidget {
  final String title;

  const ShowWinner(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 30, decoration: null),
              ),
              Button("New Game", () {
                context.read<GameController>().setNewGame();
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
