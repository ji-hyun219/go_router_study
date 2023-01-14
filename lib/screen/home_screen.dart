import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/default_layout.dart';
import 'three_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: const Text('Go OneScreen')),
        ElevatedButton(
            onPressed: () {
              context.goNamed(ThreeScreen.routeName); // Named Router
              // context.go('/one/two/three');
            },
            child: const Text('Go ThreeScreen'))
      ],
    ));
  }
}
