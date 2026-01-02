class CustomerModel {
  final String name;
  final String productType;
  final String phoneNumber;
  final String address;
  final DateTime paymentDate;
  final DateTime deadlineDate;

  CustomerModel({
    required this.name,
    required this.productType,
    required this.phoneNumber,
    required this.paymentDate,
    required this.deadlineDate,
    required this.address,
  });

  // Factory constructor to create Customer from JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'],
      productType: json['productType'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      paymentDate: DateTime.parse(json['paymentDate']),
      deadlineDate: DateTime.parse(json['deadlineDate']),
    );
  }

  // Method to convert Customer to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productType': productType,
      'phoneNumber': phoneNumber,
      'address' : address,
      'paymentDate': paymentDate.toIso8601String(),
      'deadlineDate': deadlineDate.toIso8601String(),
    };
  }
}