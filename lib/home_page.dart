import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'pages/words_page.dart' as words_page;
import 'pages/sunflower_page.dart' as sunflower_page;
import 'pages/settings_page.dart' as settings_page;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget selectedPage;
    switch (selectedIndex) {
      case 0:
        selectedPage = const words_page.WordsPage();
        break;
      case 2:
        selectedPage = const sunflower_page.Sunflower();
      case 1:
        selectedPage = const settings_page.SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: selectedPage,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(icon: LineIcons.home, text: '一言'),
                    GButton(icon: LineIcons.tools, text: '设置'),
                    GButton(icon: LineIcons.question, text: '关于'),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    setState(() => selectedIndex = index);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
