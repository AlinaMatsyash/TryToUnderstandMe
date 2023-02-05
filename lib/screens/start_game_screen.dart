import 'package:flutter/material.dart';
import 'package:try_understand_me/constants/constant.dart';
import 'package:try_understand_me/models/team.dart';
import 'game_screen.dart';

class StartGame extends StatelessWidget {
  Team team;

  StartGame(this.team, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Смахните вверх при верном ответе",
                style: mediumFontStyle,
              ),
              const Icon(
                Icons.keyboard_arrow_up,
                size: 70,
                color: Colors.green,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return GameScreen(team);
                    },
                  ));
                },
                child: Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                      color: Colors.teal, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      'Начать'.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 70,
                color: Colors.red,
              ),
              Text('Смахните вниз для пропуска слова', style: mediumFontStyle)
            ],
          ),
        ),
      ),
    );
  }
}
