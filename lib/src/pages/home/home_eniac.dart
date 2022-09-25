import 'dart:io';

import 'package:eniac_proj/models/clientes_models.dart';
import 'package:eniac_proj/src/componentes/button_eniac.dart';
import 'package:eniac_proj/src/pages/bancos/bancos.dart';
import 'package:eniac_proj/src/pages/contas_pagar/contas_pagar.dart';
import 'package:eniac_proj/src/pages/contas_pagas/contas_pagas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/colors.dart' as colors;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ClientesModels> clienteList = <ClientesModels>[];
  File? _image;
  String data = DateTime.now().toString();
  bool pagar = true;

  Future imagem(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final imagemSalva = await salvarImage(img.path);

      setState(() {
        _image = imagemSalva;
      });
    } catch (e) {
      debugPrint('Erro ao carregar imagem $e');
    }
  }

  Future<File> salvarImage(String imgPath) async {
    final directory = await getApplicationDocumentsDirectory();
    const nome = 'imagem.jpg';
    final imgem = File('${directory.path}/$nome');
    debugPrint('Caminho da imagem $imgem');

    return File(imgPath).copy(imgem.path);
  }

  @override
  void initState() {
    super.initState();
    pagar = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  end: Alignment.bottomRight,
                                  begin: Alignment.bottomLeft,
                                  colors: [Colors.blue, Colors.transparent]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(700),
                                  topRight: Radius.circular(1000))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Seja bem-vindo\n'
                                      'Nome Empresa',
                                      style: GoogleFonts.roboto(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: colors.customWhite,
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  elevation: 2,
                                                  title: const Text(
                                                      'Menu de opções'),
                                                  content: const Text(
                                                      'Escolha uma das opções abaixo'),
                                                  actionsAlignment:
                                                      MainAxisAlignment.center,
                                                  actions: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: SizedBox(
                                                        width: 200,
                                                        height: 50,
                                                        child: ButtonEniac(
                                                            colorBackground: colors
                                                                .customBackground,
                                                            onPressed:
                                                                () async {
                                                              await imagem(
                                                                  ImageSource
                                                                      .gallery);
                                                              if (mounted) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            text:
                                                                'Galeria de fotos'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: SizedBox(
                                                        width: 200,
                                                        height: 50,
                                                        child: ButtonEniac(
                                                            colorBackground: colors
                                                                .customBackground,
                                                            onPressed:
                                                                () async {
                                                              await imagem(
                                                                  ImageSource
                                                                      .camera);
                                                              if (mounted) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            text: 'Tirar foto'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: SizedBox(
                                                        width: 200,
                                                        height: 50,
                                                        child: ButtonEniac(
                                                          colorBackground: colors
                                                              .customBackground,
                                                          onPressed: () async {
                                                            // await Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //     builder: (context) =>
                                                            //         MenuGetMoments(

                                                            //       image: _image,
                                                            //     ),
                                                            //   ),
                                                            // );
                                                          },
                                                          text: 'Menu',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors.customWhite,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: _image != null
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: Image.file(
                                                    _image!,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.blue,
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/Eniac.png',
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 180,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 200,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.bottomRight,
                        begin: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.transparent]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(1000),
                        topRight: Radius.circular(2000))),
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    showAuth(context);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 10),
                          child: Text(
                            'Saldo da conta:',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 10),
                          child: Text(
                            'R\$ 500,00',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 40, bottom: 10),
                              child: Text(
                                'Contas a pagar 25/09/2022: ',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 10),
                              child: Text(
                                'R\$ 500,00',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.1,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.bottomLeft,
                                colors: [Colors.blue, Colors.transparent]),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(700),
                                topRight: Radius.circular(1000))),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PagasContas()));
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.wallet,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Contas Pagas',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ContasPagar(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.archive,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Contas\nCadastradas',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.task,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'DDA',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Bancos(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.bank,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Bancos\nCadastrados',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text('Imposto de Renda'),
                                          content: Text(
                                              'Seu imposto de renda foi calculado com sucesso!\nEnviamos um e-mail com o resultado.'),
                                        );
                                      });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.bill,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Cal. IPRF',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: colors.customBackground,
                              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text('Relatórios'),
                                          content: Text(
                                              'Enviamos um e-mail com todos os relatórios.\n- Contas a pagar\n- Contas pagas\n- Mensal\n- Semanl e Diário'),
                                        );
                                      });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(
                                        Iconsax.textalign_center,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Relatorios',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: colors.customBackground,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Center(
                                child: Image.asset(
                                  'assets/Eniac.png',
                                  width: 300,
                                  height: 300,
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text(
                    'ENIAC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAuth(BuildContext context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Autorização',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pagar = true;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            pagar
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: pagar
                                ? colors.customGreen
                                : colors.customGreyLight,
                            size: pagar ? 20 : 14,
                          ),
                          Text(
                            'Autorizar Pagamento',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: colors.customBackground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pagar = false;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            !pagar
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: !pagar
                                ? colors.customRed
                                : colors.customGreyLight,
                            size: !pagar ? 20 : 14,
                          ),
                          Text(
                            'Pagamento não Autorizado',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: colors.customBackground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Valores: ',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: colors.customBackground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'R\$ 1.000,00',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: colors.customBackground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonEniac(
                    text: 'Autorizar',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    colorBackground: colors.customBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
