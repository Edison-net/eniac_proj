import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/colors.dart' as colors;

class Bancos extends StatefulWidget {
  const Bancos({super.key});

  @override
  State<Bancos> createState() => _BancosState();
}

class _BancosState extends State<Bancos> {
  List<Map<String, dynamic>> _bancos = [];
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _agenciaController = TextEditingController();
  bool star = false;

  final _bancoContas = Hive.box('banco_contas');

  @override
  void initState() {
    super.initState();
    _refreshItens();
  }

  void _refreshItens() {
    final data = _bancoContas.keys.map((key) {
      final value = _bancoContas.get(key);
      return {
        "key": key,
        "nome": value["nome"],
        "conta": value["conta"],
      };
    }).toList();

    setState(() {
      _bancos = data.reversed.toList();
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _bancoContas.add(newItem);
    _refreshItens();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _bancoContas.put(itemKey, item);
    _refreshItens();
  }

  Future<void> _deleteItem(int itemKey) async {
    _bancoContas.delete(itemKey);
    _refreshItens();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item deletado"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Bancos", style: TextStyle(color: colors.customWhite)),
        centerTitle: true,
        backgroundColor: colors.customBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colors.customWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _bancos.isEmpty
          ? const Center(
              child: Text("Nenhum banco cadastrado"),
            )
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.bottomRight,
                      begin: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.transparent]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(700),
                      topRight: Radius.circular(1000))),
              child: ListView.builder(
                itemCount: _bancos.length,
                itemBuilder: (context, index) {
                  final item = _bancos[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        onTap: () => _showForm(
                          context,
                          item['key'],
                        ),
                        leading: const CircleAvatar(
                          child: Icon(Iconsax.bank),
                        ),
                        title: Text(item["nome"]),
                        subtitle: Text(item["conta"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: star == true
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  starColor(item["key"]);
                                }),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteItem(item['key']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.customBackground,
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void starColor([int? index]) {
    setState(() {
      star = !star;
    });
  }

  void _showForm(BuildContext context, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          _bancos.firstWhere((element) => element["key"] == itemKey);
      _nomeController.text = existingItem["nome"];
      _agenciaController.text = existingItem["conta"];
    }
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nomeController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: 'Nome da Instituição Financeira',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _agenciaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Conta corrente',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Iconsax.bank,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (itemKey == null) {
                  _createItem({
                    "nome": _nomeController.text,
                    "conta": _agenciaController.text,
                  });
                }
                if (itemKey != null) {
                  _updateItem(itemKey, {
                    "nome": _nomeController.text,
                    "conta": _agenciaController.text,
                  });
                }
                _nomeController.text = '';
                _agenciaController.text = '';

                Navigator.of(context).pop();
              },
              child: Text(itemKey == null ? 'Adicionar' : 'Atualizar'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
