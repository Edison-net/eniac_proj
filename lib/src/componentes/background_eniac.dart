import 'package:flutter/material.dart';

class Backgroundcolor extends StatelessWidget {
  final Widget child;
  const Backgroundcolor({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(55, 26, 70, 1),
            Color.fromRGBO(55, 26, 70, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: child,
    );
  }
}
