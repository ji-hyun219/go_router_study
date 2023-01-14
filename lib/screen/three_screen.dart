import 'package:flutter/material.dart';

import '../layout/default_layout.dart';

class ThreeScreen extends StatelessWidget {
  static String get routeName => 'three';

  const ThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        children: const [],
      ),
    );
  }
}
