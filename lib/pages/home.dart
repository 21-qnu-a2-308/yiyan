import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'words/home.dart' as words_page;
import 'about/home.dart' as about_page;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget selectedPage;
    switch (_selectedIndex) {
      case 0:
        selectedPage = const words_page.WordsPage();
        break;
      case 2:
        selectedPage = const about_page.AboutPage();
      case 1:
        selectedPage = const Scaffold();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
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
                    GButton(icon: LineIcons.bookOpen, text: '一言'),
                    GButton(icon: LineIcons.building, text: '泉师'),
                    GButton(icon: LineIcons.question, text: '关于'),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() => _selectedIndex = index);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
