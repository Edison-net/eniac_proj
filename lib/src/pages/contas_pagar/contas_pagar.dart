import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive/hive.dart';

import '../../utils/colors.dart' as colors;

class ContasPagar extends StatefulWidget {
  const ContasPagar({Key? key}) : super(key: key);

  @override
  State<ContasPagar> createState() => _ContasPagarState();
}

class _ContasPagarState extends State<ContasPagar> {
  List<Map<String, dynamic>> _itens = [];

  final _contaPagar = Hive.box('contas_pagar');

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
      if (barcodeScanRes.contains('http')) {
        String aux = barcodeScanRes;
        int i = aux.indexOf('peca=') + 5;
        int f = aux.indexOf('codigo=') - 1;
        barcodeScanRes = barcodeScanRes.substring(i, f);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _codbarController.text = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshItens();
  }

  void _refreshItens() {
    final data = _contaPagar.keys.map((key) {
      final value = _contaPagar.get(key);
      return {
        "key": key,
        "descricao": value["descricao"],
        "codbar": value["codbar"],
        "data_vencimento": value["data_vencimento"],
        "valor": value["valor"],
      };
    }).toList();

    setState(() {
      _itens = data.reversed.toList();
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _contaPagar.add(newItem);
    _refreshItens();
  }

  Map<String, dynamic> _readItem(int key) {
    final item = _contaPagar.get(key);
    return item;
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _contaPagar.put(itemKey, item);
    _refreshItens();
  }

  Future<void> _deleteItem(int itemKey) async {
    _contaPagar.delete(itemKey);
    _refreshItens();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item deletado"),
      ),
    );
  }

  final TextEditingController _codbarController = TextEditingController();

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataVenciemntoController =
      TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  void _showForm(BuildContext context, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          _itens.firstWhere((element) => element["key"] == itemKey);
      _descricaoController.text = existingItem["descricao"];
      _codbarController.text = existingItem["codbar"];
      _dataVenciemntoController.text = existingItem["data_vencimento"];
      _valorController.text = existingItem["valor"];
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
              controller: _descricaoController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                hintText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _codbarController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'Descrição',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: () async {
                      await scanBarcodeNormal();
                    }),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dataVenciemntoController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                hintText: 'Data de vencimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (itemKey == null) {
                  _createItem({
                    "descricao": _descricaoController.text,
                    "codbar": _codbarController.text,
                    "data_vencimento": _dataVenciemntoController.text,
                    "valor": _valorController.text,
                  });
                }
                if (itemKey != null) {
                  _updateItem(itemKey, {
                    "descricao": _descricaoController.text,
                    "codbar": _codbarController.text,
                    "data_vencimento": _dataVenciemntoController.text,
                    "valor": _valorController.text,
                  });
                }
                _descricaoController.text = '';
                _codbarController.text = '';
                _dataVenciemntoController.text = '';
                _valorController.text = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.customBackground,
        title: const Text(
          'Contas cadastradas',
          style: TextStyle(
              fontFamily: 'Verdana', fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _itens.isEmpty
          ? const Center(
              child: Text('Nenhuma conta cadastrada'),
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
                itemCount: _itens.length,
                itemBuilder: ((_, index) {
                  final currentItem = _itens[index];
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
                            currentItem["descricao"],
                          ),
                          subtitle: Text(
                            'Data:${currentItem["data_vencimento"]}\nR\$ ${currentItem["valor"]}\nCódigo de barras: ${currentItem["codbar"]}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showForm(
                                  context,
                                  currentItem['key'],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteItem(currentItem['key']),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
}
