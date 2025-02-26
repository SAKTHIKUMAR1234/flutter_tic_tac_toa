import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictactoa/Theme/mycustomtheme.dart';
import '../Widgets/app_bar.dart';
import '../Widgets/ttt_common.dart';

class GameScreen extends StatefulWidget {
  final String humanOption;
  final String mode;
  const GameScreen({super.key, required this.humanOption, required this.mode});

  @override
  State<StatefulWidget> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  List<List<String?>> board = List.generate(3, (_) => List.filled(3, null));
  static int boardSize = 3;

  static Map<int, dynamic> resultMap = {
    1: {"title": "Win", "subtitle": "Congratulations! You WON!"},
    0: {"title": "Draw", "subtitle": "The Match is a Draw"},
    -1: {"title": "Lose", "subtitle": "Computer Won This Battle"},
  };

  late String currPlayer;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    currPlayer = widget.humanOption == 'x' ? 'Human' : 'Computer';
    if (currPlayer == 'Computer') {
      Future.delayed(Duration(milliseconds: 500), widget.mode=='easy'? playAsRandom : playAsHard);
    }
  }

  void switchPlayers() {
    currPlayer = currPlayer == "Computer" ? "Human" : "Computer";
  }

  void declareResult(int result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(resultMap[result]['title']),
            content: Text(resultMap[result]['subtitle']),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
          ),
    );
  }

  int? checkForResult() {
    for (var i = 0; i < boardSize; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return board[i][0] == widget.humanOption ? 1 : -1;
      }
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return board[0][i] == widget.humanOption ? 1 : -1;
      }
    }
    if (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0] == widget.humanOption ? 1 : -1;
    }
    if (board[0][2] != null &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2] == widget.humanOption ? 1 : -1;
    }
    return board.expand((row) => row).contains(null) ? null : 0;
  }

  void playAsHard() {
    int bestVal = -1000;
    int bestRow = -1;
    int bestCol = -1;
    String aiOption = widget.humanOption == 'x' ? 'o' : 'x';

    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (board[i][j] == null) {
          board[i][j] = aiOption;
          int moveVal = minimax(board, 0, false);
          board[i][j] = null;

          if (moveVal > bestVal) {
            bestVal = moveVal;
            bestRow = i;
            bestCol = j;
          }
        }
      }
    }
    if (bestRow != -1 && bestCol != -1) {
      gestureTrigger(bestRow, bestCol);
    }
  }

  int minimax(List<List<String?>> board, int depth, bool isMax) {
    int? score = checkForResult();
    if (score != null) return score == 1 ? -10 : (score == -1 ? 10 : 0);

    int best = isMax ? -1000 : 1000;
    String aiOption = widget.humanOption == 'x' ? 'o' : 'x';
    String playerOption = widget.humanOption;

    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (board[i][j] == null) {
          board[i][j] = isMax ? aiOption : playerOption;
          int val = minimax(board, depth + 1, !isMax);
          board[i][j] = null;
          best = isMax ? max(best, val) : min(best, val);
        }
      }
    }
    return best;
  }

  void playAsRandom() {
    Map<int, dynamic> positions = {};
    int curr = 0;
    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < board[i].length; j++) {
        if (board[i][j] == null) {
          positions[curr] = {"i": i, "j": j};
        }
        curr++;
      }
    }
    if (positions.isEmpty) {
      return;
    }
    var t = positions.keys;
    var choosen = t.elementAt(Random().nextInt(t.length));
    gestureTrigger(positions[choosen]['i'], positions[choosen]['j']);
  }

  void gestureTrigger(int rowIndex, int colIndex) {
    if (board[rowIndex][colIndex] != null || loading) return;
    loading = true;
    board[rowIndex][colIndex] =
        currPlayer == "Human"
            ? widget.humanOption
            : (widget.humanOption == 'x' ? 'o' : 'x');
    setState(() => loading = false);

    int? result = checkForResult();
    if (result != null) {
      declareResult(result);
    } else {
      switchPlayers();
      if (currPlayer == "Computer") {
        Future.delayed(Duration(milliseconds: 500), widget.mode=='easy'? playAsRandom : playAsHard);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;

    double getWindowWidth() {
      if (width > 700) {
        return 700;
      }
      if (width < 300) {
        return 300;
      }
      return width;
    }

    List<double> getGridChildHeightAndWidth() {
      double itemWidth = (getWindowWidth() / 3) - 50;
      double itemHeight = (getWindowWidth() / 3) - 50;
      return [itemWidth, itemHeight];
    }

    String? getEleValue(int row, int col) {
      return board[row][col]?.toString();
    }

    List<double> itemWH = getGridChildHeightAndWidth();

    Widget getTurnDisplay() {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(179, 197, 197, 197),
          ),
          color: Colors.teal[200],
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            "${currPlayer == "Computer" ? "Computer's" : "Your's"} Turn",
          ),
        ),
      );
    }

    return Scaffold(
      appBar: TTTAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(fit: BoxFit.fill, child: getTurnDisplay()),
            SizedBox(
              width: getWindowWidth(),
              height: getWindowWidth(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: buttonBackgroundColor, width: 10),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children:
                        board
                            .asMap()
                            .entries
                            .expand(
                              (rowEntry) => rowEntry.value.asMap().entries.map(
                                (colEntry) => Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!loading && currPlayer == 'Human') {
                                        gestureTrigger(
                                          rowEntry.key,
                                          colEntry.key,
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: itemWH[1],
                                      width: itemWH[0],
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 5,
                                          color: buttonBackgroundColor,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: TttCommon(
                                        character: getEleValue(
                                          rowEntry.key,
                                          colEntry.key,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
