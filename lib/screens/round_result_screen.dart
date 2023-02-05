import 'package:flutter/material.dart';
import 'package:try_understand_me/models/team.dart';
import 'package:try_understand_me/models/word.dart';
import 'package:try_understand_me/screens/start_game_screen.dart';

import '../constants/constant.dart';
import 'final_screen.dart';
import '../controller/game_controller.dart';

class RoundResultScreen extends StatefulWidget {
  @override
  _RoundResultScreenState createState() => _RoundResultScreenState();
  final GameController _gameController = GameController.getInstance();
  Team team;
  List<Word> words;

  RoundResultScreen(this.team, this.words, {super.key});
}

class _RoundResultScreenState extends State<RoundResultScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  var tabs = [
    const Tab(
      text: "Счет за раунд",
    ),
    const Tab(
      text: 'Общий счет',
    )
  ];
  late List<Word> _words;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _words = widget.words.where((element) => element.isUsed).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs,
          ),
          centerTitle: true,
          title: Text(widget.team.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text('Количество очков', style: mediumFontStyle),
                        const Spacer(),
                        Text(
                          widget.team.score.toString(),
                          style: mediumFontStyle,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _words.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    _words[index].value,
                                    style: mediumFontStyle,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      iconSize: 30,
                                      icon: Icon(
                                        _words[index].isKnown
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _words[index].isKnown =
                                              !_words[index].isKnown;
                                          if (_words[index].isKnown) {
                                            if (widget._gameController
                                                .minusNegativeScore) {
                                              widget.team.score += 2;
                                            } else {
                                              widget.team.score++;
                                            }
                                          } else {
                                            if (widget._gameController
                                                .minusNegativeScore) {
                                              widget.team.score -= 2;
                                            } else {
                                              widget.team.score--;
                                            }
                                          }
                                        });
                                      })
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
                Column(children: [
                  // Row(
                  //   children: [Text('Командалэн нимыз'), Text(widget.team.score.toString())],
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget._gameController.teams.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Text(
                                    widget._gameController.teams[index].title,
                                    style: mediumFontStyle,
                                  ),
                                  const Spacer(),
                                  Text(widget._gameController.teams[index].score
                                      .toString())
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ]),
            ),
            InkWell(
              onTap: () {
                if (widget.team.score >= widget._gameController.scoreToWin) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => FinalScreen(widget.team),
                  ));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        StartGame(widget._gameController.getNextTeam()),
                  ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 50,
                  width: 175,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'Продолжить'.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
