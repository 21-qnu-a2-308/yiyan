import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart' as show_up;

import 'dart:math' as math;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  static const _maxSeeds = 100;
  var _seeds = _maxSeeds ~/ 2;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('关于')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(children: [
                Center(
                  child: SunflowerWidget(_seeds, _maxSeeds),
                ),
                if (_seeds > 70)
                  Center(
                      child: show_up.ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 700),
                    curve: Curves.ease,
                    direction: show_up.Direction.vertical,
                    offset: 0.5,
                    child: Card(
                      color: theme.colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('2024年4月9日', style: style),
                      ),
                    ),
                  )),
                if (_seeds < 30)
                  Center(
                      child: show_up.ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 700),
                    curve: Curves.ease,
                    direction: show_up.Direction.vertical,
                    offset: 0.5,
                    child: Card(
                      color: theme.colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('江叶琦', style: style),
                      ),
                    ),
                  )),
              ]),
            ),
            const SizedBox(height: 20),
            Text('${_seeds.round()}'),
            SizedBox(
              width: 300,
              child: Slider(
                min: 0,
                max: _maxSeeds.toDouble(),
                value: _seeds.toDouble(),
                onChanged: (val) {
                  setState(() => _seeds = val.round());
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SunflowerWidget extends StatelessWidget {
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 40;
  static const size = 600.0;
  static final phi = (math.sqrt(5) + 1) / 2;
  static final rng = math.Random();

  final int _seeds, _maxSeeds;

  const SunflowerWidget(this._seeds, this._maxSeeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final seedWidgets = <Widget>[];

    for (var i = 0; i < _seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;

      seedWidgets.add(AnimatedAlign(
        key: ValueKey(i),
        duration: Duration(milliseconds: rng.nextInt(500) + 250),
        curve: Curves.easeInOut,
        alignment: Alignment(r * math.cos(theta), -1 * r * math.sin(theta)),
        child: const Dot(true),
      ));
    }

    for (var j = _seeds; j < _maxSeeds; j++) {
      final x = math.cos(tau * j / (_maxSeeds - 1)) * 0.9;
      final y = math.sin(tau * j / (_maxSeeds - 1)) * 0.9;

      seedWidgets.add(AnimatedAlign(
        key: ValueKey(j),
        duration: Duration(milliseconds: rng.nextInt(500) + 250),
        curve: Curves.easeInOut,
        alignment: Alignment(x, y),
        child: const Dot(false),
      ));
    }

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(children: seedWidgets),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  static const size = 5.0, radius = 3.0;

  final bool _lit;

  const Dot(this._lit, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _lit ? Colors.orange : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(height: size, width: size),
    );
  }
}
