import 'dart:async';

import 'package:flutter/material.dart';
import 'package:try_understand_me/models/team.dart';
import 'package:try_understand_me/models/word.dart';
import 'package:try_understand_me/screens/round_result_screen.dart';
import 'package:try_understand_me/tindercard/flutter_tindercard.dart';

import '../constants/constant.dart';
import '../controller/game_controller.dart';

class GameScreen extends StatefulWidget {
  GameScreen(this.team, {super.key});

  final GameController _gameController = GameController.getInstance();
  final Team team;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _negativeScore = 0;
  int _positiveScore = 0;
  int _elapsedTime = 6;
  int _allTime = 6;
  Timer? _timer;
  final bool _isPause = false;
  CardController cardController = CardController();
  late List<Word> _words;

  @override
  void initState() {
    _words = widget._gameController.getRandomWords();
    _allTime = widget._gameController.timeForTeam.toInt();
    _elapsedTime = _allTime;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedTime > 0) {
        setState(() {
          _elapsedTime--;
        });
      } else {
        timer.cancel();
        endGame();
      }
    });
  }

  void endGame() {
    if (widget._gameController.minusNegativeScore) {
      widget.team.score += _positiveScore + _negativeScore;
    } else {
      widget.team.score += _positiveScore;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => RoundResultScreen(widget.team, _words),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //final cardColor = Color(0xffffd166);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text(widget.team.title)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$_negativeScore',
                    style: TextStyle(fontSize: 20, color: primaryColor),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.teal,
                        value: _elapsedTime / _allTime,
                      ),
                      Text('$_elapsedTime')
                    ],
                  ),
                  Text('$_positiveScore',
                      style: const TextStyle(fontSize: 20, color: Colors.green))
                ],
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: _isPause,
                  child: TinderSwapCard(
                    cardController: cardController,
                    swipeCompleteCallback: (orientation, index) {
                      if (index == 0 &&
                          orientation != CardSwipeOrientation.RECOVER) {
                        _startTimer();
                      } else {
                        var word = _words[index - 1];
                        if (orientation == CardSwipeOrientation.UP ||
                            orientation == CardSwipeOrientation.RIGHT) {
                          setState(() {
                            _positiveScore++;
                            word.isKnown = true;
                          });
                        } else if (orientation == CardSwipeOrientation.DOWN ||
                            orientation == CardSwipeOrientation.LEFT) {
                          setState(() {
                            _negativeScore--;
                          });
                        }
                      }
                    },
                    totalNum: _words.length + 1,
                    swipeUp: true,
                    swipeDown: true,
                    swipeEdge: 3.0,
                    orientation: AmassOrientation.BOTTOM,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.width * 1.1,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    minHeight: MediaQuery.of(context).size.width * 1.0,
                    cardBuilder: (context, index, isFrontCard) {
                      if (index == 0) {
                        // learning card
                        return Card(
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.keyboard_arrow_up_outlined,
                                    color: Colors.green, size: 50),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Flexible(
                                        child: Center(
                                          child: Text(
                                            'Смахните для начала игры',
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Color(0xff073b4c),
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ]),
                                const Icon(Icons.keyboard_arrow_down_outlined,
                                    color: Colors.red, size: 50)
                              ],
                            ),
                          ),
                        );
                      } else {
                        // current word
                        var word = _words[index - 1];
                        if (isFrontCard) {
                          word.isUsed = true;
                        }
                        return Card(
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              word.value,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 40,
                                                  color: Color(0xff073b4c)),
                                            ),
                                            Visibility(
                                              visible: widget._gameController
                                                  .showTranslations,
                                              child: Text(
                                                '(${word.translation})',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
