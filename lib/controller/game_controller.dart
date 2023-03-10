import 'package:try_understand_me/models/team.dart';
import 'package:try_understand_me/models/word.dart';
import 'package:try_understand_me/models/word_entity.dart';

class GameController {
  static final GameController _instance = GameController();
  // game settings:
  double scoreToWin = 45;
  double timeForTeam = 60;
  bool minusNegativeScore = true;
  bool showTranslations = false;

  late List<Word> _words;
  List<Word> get words => _words;
  late List<Team> teams;
  int _currentTeamIndex = 0;
  int get currentTeamIndex => _currentTeamIndex;

  static GameController getInstance() {
    return _instance;
  }

  void reset() {
    _currentTeamIndex = 0;
  }

  Team getFirstTeam() {
    return teams[0];
  }

  Team getNextTeam() {
    _currentTeamIndex++;
    if (_currentTeamIndex == teams.length) {
      _currentTeamIndex = 0;
    }
    return teams[_currentTeamIndex];
  }

  Future<bool> isCurrentTeamWin() async {
    return teams[_currentTeamIndex].score >= scoreToWin;
  }

  setWordList(List<WordEntity> words) {
    _words = words.map((e) => Word(e.value, e.translation)).toList();
  }

  List<Word> getRandomWords() {
    List<Word> result = [];
    result.addAll(words.where((element) => !element.isUsed));
    result.shuffle();
    return result;
  }
}
