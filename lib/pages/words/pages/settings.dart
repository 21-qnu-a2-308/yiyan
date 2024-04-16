import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oxygen_tools/state.dart' as app_state;
import 'package:show_up_animation/show_up_animation.dart' as show_up;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return show_up.ShowUpAnimation(
      animationDuration: const Duration(milliseconds: 700),
      curve: Curves.ease,
      direction: show_up.Direction.vertical,
      offset: 0.5,
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
            child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('来源'),
                  Card(
                      color: Colors.lightGreen,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SourceSelector(),
                      )),
                  SizedBox(height: 15),
                  Text('风格'),
                  Card(
                      color: Color.fromARGB(255, 123, 152, 210),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: WordsStyleSelector(),
                      )),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class WordsStyleSelector extends StatefulWidget {
  const WordsStyleSelector({super.key});

  @override
  State<WordsStyleSelector> createState() => _WordsStyleSelectorState();
}

class _WordsStyleSelectorState extends State<WordsStyleSelector> {
  final Map<String, String> _styleTable = {
    '动画': 'a',
    '漫画': 'b',
    '游戏': 'c',
    '文学': 'd',
    '原创': 'e',
    '来自网络': 'f',
    '其他': 'g',
    '影视': 'h',
    '诗词': 'i',
    '网易云': 'j',
    '哲学': 'k',
    '抖机灵': 'l'
  };
  late String _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = '诗词';
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<app_state.AppState>();
    return DropdownButton<String>(
      value: _currentStyle,
      isExpanded: true,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      onChanged: (String? value) {
        setState(() {
          _currentStyle = value!;
          appState.wordsClient.setStyle(_styleTable[value] ?? 'i');
        });
      },
      items: _styleTable.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SourceSelector extends StatefulWidget {
  const SourceSelector({super.key});

  @override
  State<SourceSelector> createState() => _SourceSelectorState();
}

class _SourceSelectorState extends State<SourceSelector> {
  final _typeTable = ['Hitokoto'];
  late String _currentSource;

  @override
  void initState() {
    super.initState();
    _currentSource = _typeTable.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _currentSource,
      isExpanded: true,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      onChanged: (String? value) {
        setState(() {
          _currentSource = value!;
        });
      },
      items: _typeTable.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
