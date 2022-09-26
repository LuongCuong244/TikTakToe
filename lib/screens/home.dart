// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktaktoe/changenotifiers/game.controller.dart';
import 'package:tiktaktoe/changenotifiers/game.dimensions.dart';
import 'package:tiktaktoe/widgets/button.dart';
import 'package:tiktaktoe/screens/show.winner.dart';
import '../widgets/game.frame.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GameController>().setHomeScreenContext(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu_open_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(
                      color: Color.fromARGB(100, 255, 255, 255),
                      thickness: 1,
                      height: 1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60, // more than 2 * fontSize of Text
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.watch<GameDimensions>().space),
                        child: Center(
                          child: Text(
                            context.watch<GameController>().label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(100, 255, 255, 255),
                      thickness: 1,
                      height: 3,
                    ),
                    SizedBox(
                      width: context.watch<GameDimensions>().gameContainer,
                      height: context.watch<GameDimensions>().gameContainer,
                      child: GameFrame(
                        frameSize: context.watch<GameDimensions>().frameSize,
                        space: context.watch<GameDimensions>().space,
                      ),
                    ),
                    Button("Reset", context.watch<GameController>().setNewGame),
                    //Button("Custom", showCustomScreen),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Change size of the game frame:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Slider(
                                value:
                                    context.watch<GameDimensions>().frameSize,
                                min: context
                                        .watch<GameDimensions>()
                                        .gameContainer /
                                    2,
                                max: context
                                    .watch<GameDimensions>()
                                    .gameContainer,
                                onChanged: ((value) {
                                  context
                                      .read<GameDimensions>()
                                      .setFrameSize(value);
                                }))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
