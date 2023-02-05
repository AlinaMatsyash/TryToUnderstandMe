import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:try_understand_me/constants/constant.dart';
import 'package:try_understand_me/controller/game_controller.dart';
import 'package:try_understand_me/screens/team_screen.dart';

class GameSettingsScreen extends StatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  _GameSettingsScreenState createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GameController _gameController = GameController.getInstance();

  @override
  void initState() {
    super.initState();
    _prefs.then((prefs) {
      if (prefs.containsKey(scoreToWinKey)) {
        setState(() {
          var scoreToWin = prefs.getDouble(scoreToWinKey);
          if (scoreToWin != null) {
            _gameController.scoreToWin = scoreToWin;
          }
        });
      }
      if (prefs.containsKey(timeForTeamKey)) {
        setState(() {
          var timeForTeam = prefs.getDouble(timeForTeamKey);
          if (timeForTeam != null) {
            _gameController.timeForTeam = timeForTeam;
          }
        });
      }
      if (prefs.containsKey(minusScoreKey)) {
        setState(() {
          var minusNegativeScore = prefs.getBool(minusScoreKey);
          if (minusNegativeScore != null) {
            _gameController.minusNegativeScore = minusNegativeScore;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Параметры игры'),
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                const Text(
                  'Требуемое количество очков для победы',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Text(_gameController.scoreToWin.round().toString())
              ],
            ),
            Slider(
              value: _gameController.scoreToWin,
              min: 10,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _gameController.scoreToWin = value;
                  _prefs.then((pref) async =>
                      {await pref.setDouble(scoreToWinKey, value)});
                });
              },
            ),
            Row(
              children: [
                const Text('Время раунда (сек.)',
                    style: TextStyle(fontSize: 16)),
                const Spacer(),
                Text(_gameController.timeForTeam.round().toString())
              ],
            ),
            Slider(
              value: _gameController.timeForTeam,
              min: 20,
              max: 120,
              onChanged: (double value) {
                setState(() {
                  _gameController.timeForTeam = value;
                  _prefs.then((pref) async =>
                      {await pref.setDouble(timeForTeamKey, value)});
                });
              },
            ),
            SwitchListTile(
                activeColor: Colors.teal,
                title: const Text('Минус бал за пропуск'),
                value: _gameController.minusNegativeScore,
                onChanged: (bool value) {
                  setState(() {
                    _gameController.minusNegativeScore = value;
                    _prefs.then((pref) async =>
                        {await pref.setBool(minusScoreKey, value)});
                  });
                }),
            SwitchListTile(
                activeColor: Colors.teal,
                title: const Text('Показывать перевод'),
                value: _gameController.showTranslations,
                onChanged: (bool value) {
                  setState(() {
                    _gameController.showTranslations = value;
                    _prefs.then((pref) async =>
                        {await pref.setBool(showTranslations, value)});
                  });
                }),
            const Spacer()
          ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return TeamScreen();
            },
          ));
        },
      ),
    );
  }

  // void _savePref(String scoreToWinKey, double value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble(scoreToWinKey, value);
  // }
}
