import 'package:flutter/material.dart';
import 'package:try_understand_me/controller/game_controller.dart';
import 'package:try_understand_me/models/team.dart';

import '../constants/constant.dart';
import 'home_screen.dart';

class FinalScreen extends StatefulWidget {
  FinalScreen(this.team, {super.key});

  Team team;
  final GameController _gameController = GameController.getInstance();

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final List<Team> _teams = [];

  @override
  void initState() {
    _teams.addAll(widget._gameController.teams as Iterable<Team>);
    _teams.sort((a, b) => b.score.compareTo(a.score));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text('Результаты'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  const Text('Победила команда',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text(widget.team.title,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ))
                ]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _teams.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}. ${_teams[index].title}',
                              style: mediumFontStyle,
                            ),
                            const Spacer(),
                            Text(_teams[index].score.toString())
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ), (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  width: 175,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    'Продолжить'.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
