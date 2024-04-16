import 'package:flutter/material.dart';

import 'tools.dart' as tools;

final class AppState extends ChangeNotifier {
  final tools.WordsClient wordsClient = tools.WordsClient();
  final List<String> historyList = [];
  final List<String> favoritesList = [];
  GlobalKey? historyListKey;

  void getNext() async {
    if (wordsClient.getWords().isNotEmpty) {
      historyList.insert(0, wordsClient.getWords());
      var animatedList = historyListKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0);
    }
    await wordsClient.fetch();
    super.notifyListeners();
  }

  void toggleFavorite([String? words]) {
    words = words ?? wordsClient.getWords();
    if (words.isNotEmpty) {
      favoritesList.contains(words)
          ? favoritesList.remove(words)
          : favoritesList.add(words);
      super.notifyListeners();
    }
  }

  void removeFavorite(String words) {
    favoritesList.remove(words);
    super.notifyListeners();
  }
}
