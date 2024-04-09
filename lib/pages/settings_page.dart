import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart' as show_up;

import '../main.dart' as main;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
        ),
        body: show_up.ShowUpAnimation(
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
                child: Column(
                  children: [
                    Text('一言风格选择'),
                    Card(
                        color: Color.fromARGB(255, 123, 152, 210),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: WordsTypeSelector(),
                        )),
                    SizedBox(height: 10),
                    Text('一言来源选择'),
                    Card(
                        color: Colors.lightGreen,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SourceSelector(),
                        )),
                  ],
                ),
              ),
            )),
          ),
        ));
  }
}

class WordsTypeSelector extends StatefulWidget {
  const WordsTypeSelector({super.key});

  @override
  State<WordsTypeSelector> createState() => _WordsTypeSelectorState();
}

class _WordsTypeSelectorState extends State<WordsTypeSelector> {
  final Map<String, String> _typeTable = {
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
  String currentValue = '诗词';

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<main.MyAppState>();
    return DropdownButton<String>(
      value: currentValue,
      isExpanded: true,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      onChanged: (String? value) {
        setState(() {
          currentValue = value!;
          appState.wordsClient.setType(_typeTable[value] ?? 'i');
        });
      },
      items: _typeTable.keys.map<DropdownMenuItem<String>>((String value) {
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
  String currentValue = 'Hitokoto';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      isExpanded: true,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      onChanged: (String? value) {
        setState(() {
          currentValue = value!;
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
