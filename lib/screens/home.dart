import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const <Widget>[
            Expanded(
              child: Center(
                child: Text("Hello!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
