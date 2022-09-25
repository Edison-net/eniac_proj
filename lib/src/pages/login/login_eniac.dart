import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../componentes/button_eniac.dart';
import '../../componentes/logo_eniac.dart';
import '../../componentes/text_field_eniac.dart';
import '../../utils/colors.dart' as colors;
import '../home/home_eniac.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isError = false;

  var emailController = TextEditingController();
  var senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.customBackground,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.customBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const LogoEniac(),
                    const SizedBox(height: 20),
                    Text(
                      'Realize seu login',
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: colors.customWhite,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.customWhite,
                        ),
                        child: TextFieldEniac(
                          isError: isError,
                          hintText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          preffixIcon: const Icon(
                            Icons.email_outlined,
                            color: colors.customBlack,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.customWhite,
                        ),
                        child: TextFieldEniac(
                          isError: isError,
                          controller: senhaController,
                          hintText: 'Senha',
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          preffixIcon: const Icon(
                            Icons.lock_outlined,
                            color: colors.customBlack,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 140,
                            child: Center(
                              child: ButtonEniac(
                                colorBackground: Colors.blue,
                                text: 'Cadastrar',
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const CadastrarPage()));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 80,
                            width: 140,
                            child: Center(
                              child: ButtonEniac(
                                colorBackground: Colors.blue,
                                text: 'Entrar',
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
