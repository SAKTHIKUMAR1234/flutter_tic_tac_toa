import 'package:flutter/material.dart';
import '../Theme/mycustomtheme.dart';

class TTTAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TTTAppBar({super.key});

  @override
  Widget build(BuildContext content) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Tic Tac Toa",
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      backgroundColor: backgroudColor,
      leading: getBackIcon(content),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void showConfirmDialog(context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Confirm"),
          content: Text("Are You Sure to Quit?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Okay"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        ),
  );
}

Widget? getBackIcon(BuildContext context) {
  if (Navigator.canPop(context)) {
    return IconButton(
      onPressed: () => showConfirmDialog(context),
      icon: Icon(Icons.keyboard_backspace_rounded),
      style: ButtonStyle(iconColor: WidgetStateProperty.all(textColor)),
    );
  }
  return null;
}
