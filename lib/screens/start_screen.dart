import 'package:flutter/material.dart';
import '../Theme/mycustomtheme.dart';
import '../Widgets/start_body.dart';
import '../Widgets/app_bar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  String helpInstructions = """

    How to Play
      1.Players take turns placing their mark (X or O) in an empty square.
      2.The goal is to get three marks in a row (horizontally, vertically, or diagonally).
      3.If a player gets three in a row, they win immediately.
      4.If all 9 squares are filled and no one wins, the game is a draw.
      5.The game continues until there is a winner or a draw.

  """;

  void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Instructions", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black
                    ),),
                    Text(
                      helpInstructions,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(buttonBackgroundColor),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Close", style: TextStyle(
                              color: textColor
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TTTAppBar(),
      body: StartBody(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showHelpDialog(context);
        },
        backgroundColor: buttonBackgroundColor,
        hoverColor: buttonHoverColor,
        child: Icon(Icons.wb_incandescent_sharp, color: buttonTextColot),
      ),
    );
  }
}
