import 'package:flutter/material.dart';

class LogoEniac extends StatelessWidget {
  const LogoEniac({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/Eniac.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
