import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tools.dart' as tools;
import 'home_page.dart' as home_page;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 46, 150, 225)),
        ),
        home: const home_page.MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final tools.WordsClient wordsClient = tools.WordsClient();
  final List<String> historyList = [];
  final List<String> favoritesList = [];
  GlobalKey? historyListKey;

  void getNext() async {
    if (wordsClient.getCurrent().isNotEmpty) {
      historyList.insert(0, wordsClient.getCurrent());
      var animatedList = historyListKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0);
    }
    await wordsClient.getOne();
    super.notifyListeners();
  }

  void toggleFavorite([String? words]) {
    words = words ?? wordsClient.getCurrent();
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
