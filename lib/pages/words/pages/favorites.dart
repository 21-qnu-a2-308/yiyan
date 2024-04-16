import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oxygen_tools/state.dart' as app_state;
import 'package:show_up_animation/show_up_animation.dart' as show_up;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.watch<app_state.AppState>();

    if (appState.favoritesList.isEmpty) {
      return const Center(child: Text('什么也没有收藏'));
    }

    return show_up.ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 700),
      curve: Curves.ease,
      direction: show_up.Direction.vertical,
      offset: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text('目前有 ${appState.favoritesList.length} 个收藏:'),
              ),
              Expanded(
                child: Column(
                  children: [
                    for (var words in appState.favoritesList)
                      ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              semanticLabel: '删除'),
                          color: theme.colorScheme.primary,
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('确定要删除吗？'),
                              content: const Text('点击确定删除此条收藏'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, '取消'),
                                  child: const Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, '确定');
                                    appState.removeFavorite(words);
                                  },
                                  child: const Text('确定'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        title: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              foregroundColor: theme.colorScheme.background,
                              backgroundColor: theme.colorScheme.primary),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  words,
                                  style: theme.textTheme.displaySmall!.copyWith(
                                    fontSize: 20,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
