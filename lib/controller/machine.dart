class Machine {
  final String machineName;
  final int price;
  final String weldingType;
  final String imageLink;
  final String productType;

  const Machine({
    required this.machineName,
    required this.price,
    required this.weldingType,
    required this.imageLink,
    required this.productType,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      machineName: json['ItemName'] as String,
      price: json['Price'] as int,
      weldingType: json['Weldingtype'] as String,
      imageLink: json['link'] as String,
      productType: json['ItemType'] as String,
    );
  }
}
