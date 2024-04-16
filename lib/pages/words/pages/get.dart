import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:oxygen_tools/state.dart' as app_state;
import 'package:show_up_animation/show_up_animation.dart' as show_up;

class ShowWordsCard extends StatelessWidget {
  const ShowWordsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<app_state.AppState>();
    var wordsStr = appState.wordsClient.getWords();
    var theme = Theme.of(context);
    var style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    late IconData icon;
    if (appState.favoritesList.contains(wordsStr)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Card(
      color: theme.colorScheme.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: AutoSizeText(
                wordsStr,
                style: style,
                maxFontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (appState.wordsClient.getWho().isNotEmpty)
                  Text(
                    '作者: ${appState.wordsClient.getWho()}',
                    style: style.copyWith(fontSize: 15),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                const SizedBox(height: 10),
                if (appState.wordsClient.getFrome().isNotEmpty)
                  Text(
                    '出处：${appState.wordsClient.getFrome()}',
                    style: style.copyWith(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => appState.toggleFavorite(),
                  icon: Icon(icon),
                  label: const Text('收藏'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => appState.getNext(),
                  child: const Text('下一个'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryViewList extends StatefulWidget {
  const HistoryViewList({super.key});

  @override
  State<HistoryViewList> createState() => _HistoryViewListState();
}

class _HistoryViewListState extends State<HistoryViewList> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<app_state.AppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
        initialItemCount: appState.historyList.length,
        itemBuilder: (context, index, animation) {
          final String words = appState.historyList[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () => appState.toggleFavorite(words),
                icon: appState.favoritesList.contains(words)
                    ? const Icon(Icons.favorite, size: 12)
                    : const SizedBox(),
                label: Text(words),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GetPage extends StatelessWidget {
  const GetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return show_up.ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 700),
      curve: Curves.ease,
      direction: show_up.Direction.vertical,
      offset: 0.5,
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: HistoryViewList()),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ShowWordsCard(),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
