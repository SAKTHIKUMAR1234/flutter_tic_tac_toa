import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/game_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StartBody extends StatefulWidget {
  const StartBody({super.key});

  @override
  State<StatefulWidget> createState() => _StartBody();
}

class _StartBody extends State<StartBody> {
  static const List<Map<String, String>> radioOptions = [
    {"value": 'x', "desc": "X (X will Take The First Move)"},
    {"value": 'o', "desc": "O"},
  ];

  String _option = 'x';
  String _mode = "easy";

  void changeRadio(String val) {
    setState(() {
      _option = val;
    });
  }

  void changeMode(mode) {
    _mode = mode;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ToggleSwitch(
                  initialLabelIndex: _mode == 'easy' ? 0 : 1,
                  totalSwitches: 2,
                  labels: ['Easy', 'Hard'],
                  customWidths: [100, 100],
                  icons: [FontAwesomeIcons.angellist, FontAwesomeIcons.skull],
                  onToggle: (index) {
                    if (index == 0) {
                      changeMode('easy');
                    } else {
                      changeMode('hard');
                    }
                  },
                ),
              ),
            ),
            Wrap(
              spacing: 60,
              runSpacing: 10,
              children:
                  radioOptions.map((item) {
                    return GestureDetector(
                      onTap: () => changeRadio(item['value']!),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio<String>(
                            value: item['value']!,
                            groupValue: _option,
                            onChanged: (val) => changeRadio(val!),
                          ),
                          SizedBox(width: 10),
                          Text(
                            item['desc'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => GameScreen(humanOption: _option, mode: _mode,),
                          ),
                        );
                      },
              child: const Text(
                "Start Game",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
