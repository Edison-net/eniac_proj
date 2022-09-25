// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pagas {
  final String descricao;
  final String valor;
  final String data;
  Pagas({
    required this.descricao,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valor': valor,
      'data': data,
    };
  }
}
