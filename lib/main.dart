import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state.dart' as app_state;
import 'pages/home.dart' as home_page;

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => app_state.AppState(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 46, 150, 225)),
        ),
        home: const home_page.HomePage(),
      ),
    );
  }
}
