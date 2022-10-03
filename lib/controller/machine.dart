class Machine {
  final String machineName;
  final int price;
  final String Machinetype;
  final String imageLink;
  final String productType;

  const Machine({
    required this.machineName,
    required this.price,
    required this.Machinetype,
    required this.imageLink,
    required this.productType,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      machineName: json['ItemName'] as String,
      price: json['Price'] as int,
      Machinetype: json['type'] as String,
      imageLink: json['link'] as String,
      productType: json['ItemType'] as String,
    );
  }
}
