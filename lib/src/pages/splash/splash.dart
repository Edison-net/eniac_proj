import 'package:flutter/material.dart';

import '../../componentes/background_eniac.dart';
import '../login/login_eniac.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundcolor(
        child: Center(
          child: Image.asset(
            'assets/Eniac.png',
            width: 400,
            height: 400,
          ),
        ),
      ),
    );
  }
}
