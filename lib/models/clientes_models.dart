class ClientesModels {
  final String customerId = '595.080.896-84';
  final String customerName = 'Cliente 00001';
  final String organizationId = '69665991-da55-4aac-a1f2-32d23daba8fe';
  final String organizationName = 'Instituição Financeira 03';
  final String organizationCnpj = '00.047.912/7906-49';

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'customerName': customerName,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCnpj': organizationCnpj,
      };
}
