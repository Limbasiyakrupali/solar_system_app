import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  bool istapped = false;
  void ChangeTheme() {
    istapped = !istapped;
    notifyListeners();
  }
}
