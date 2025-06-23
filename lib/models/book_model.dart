class BookModel {
  final String serviceType;
  final DateTime timestamp;

  BookModel({required this.serviceType, required this.timestamp});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(serviceType: json['service_type'] as String, timestamp: DateTime.parse(json['date'] as String));
  }

  Map<String, dynamic> toJson() {
    return {'service_type': serviceType, 'date': timestamp.toIso8601String()};
  }
}
