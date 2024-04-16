import 'package:flutter/material.dart';
import 'pages/get.dart';
import 'pages/favorites.dart';
import 'pages/settings.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: '获取'),
              Tab(icon: Icon(Icons.favorite), text: '收藏'),
              Tab(icon: Icon(Icons.settings), text: '设置'),
            ],
          ),
          title: const Text('一言'),
        ),
        body: const TabBarView(
          children: [
            GetPage(),
            FavoritesPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
