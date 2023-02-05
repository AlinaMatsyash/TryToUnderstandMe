import 'package:flutter/material.dart';
import 'package:try_understand_me/data/word_list.dart';

import '../controller/game_controller.dart';
import 'game_settings_screen.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Выбери словарь'),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Слова на Английском(простые)'),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/1.png")),
                ),
                subtitle: Text('${easyWords.length} слов'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      GameController.getInstance().setWordList(easyWords);
                      return const GameSettingsScreen();
                    },
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Слова на Английском(средние)'),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/2.png")),
                ),
                subtitle: Text('${mediumWords.length} слов'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      GameController.getInstance().setWordList(mediumWords);
                      return const GameSettingsScreen();
                    },
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Слова на Английском(сложные)'),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/3.png")),
                ),
                subtitle: Text('${hardWords.length} слов'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      GameController.getInstance().setWordList(hardWords);
                      return const GameSettingsScreen();
                    },
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text(
                    'Часто испльзуемые слова(+ перевод на Английский)'),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/4.png")),
                ),
                subtitle: Text('${words.length} слов'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      GameController.getInstance().setWordList(words);
                      return const GameSettingsScreen();
                    },
                  ));
                },
              ),
            ),
          ],
        ));
  }
}
