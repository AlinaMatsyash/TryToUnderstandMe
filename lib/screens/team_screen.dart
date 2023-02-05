import 'dart:math';

import 'package:flutter/material.dart';
import 'package:try_understand_me/screens/start_game_screen.dart';
import '../controller/game_controller.dart';
import '../models/team.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<String> title = [
    'Жирафики',
    'Бобры',
    'Смелые ребята',
    'Моржи',
    'Утки',
    'Псы',
    'Волки',
    'Альфы',
    'Кальмыры',
    'Львы',
    'Ламы',
    'Девчата',
    'Черепахи',
    'Панды',
  ];
  List<Team> teams = [];
  late GameController _gameController;

  String generateRandomTeam() {
    int randomIndex = Random().nextInt(title.length - 1);
    var result = title[randomIndex];
    title.removeAt(randomIndex);
    return result;
  }

  @override
  void initState() {
    teams.add(Team(generateRandomTeam()));
    teams.add(Team(generateRandomTeam()));
    _gameController = GameController.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Команды'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == teams.length) {
                  return const SizedBox();
                } else {
                  var team = teams[index];
                  var controller = TextEditingController(text: team.title);
                  controller.addListener(() {
                    team.title = controller.text;
                  });
                  var focusNode = FocusNode();
                  return Card(
                      child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          readOnly: team.readOnly,
                          focusNode: focusNode,
                          decoration: null,
                          controller: controller,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            team.readOnly = false;
                          });
                          focusNode.requestFocus();
                        },
                      )
                    ]),
                  ));
                }
              },
              itemCount: teams.length + 1,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              _gameController.reset();
              _gameController.teams = teams;
              return StartGame(_gameController.getFirstTeam());
            },
          ));
        },
      ),
    );
  }
}
