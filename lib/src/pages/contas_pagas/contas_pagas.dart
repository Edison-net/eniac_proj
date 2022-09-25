import 'package:flutter/material.dart';

import '../../../models/pagas.dart';
import '../../utils/colors.dart' as colors;

class PagasContas extends StatelessWidget {
  PagasContas({Key? key}) : super(key: key);

  // Generate a massive list of dummy products
  final List<Pagas> pagas = List.generate(
    20,
    (index) => Pagas(
      descricao: 'Descrição da conta',
      valor: 'R\$ 100,00',
      data: '01/01/2021',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('Contas Pagas', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: colors.customBackground,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.transparent]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(700),
                  topRight: Radius.circular(1000))),
          child: ListView.builder(
              itemCount: pagas.length,
              itemBuilder: (context, index) {
                final Pagas paga = pagas[index];
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.amber[100],
                          child: const Icon(
                            Icons.file_copy,
                            color: colors.customBackground,
                          ),
                        ),
                        title: Text(
                          paga.descricao,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Valor: ${paga.valor} - Data: ${paga.data}',
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
