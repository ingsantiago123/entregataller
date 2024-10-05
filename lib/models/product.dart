class Product {
  final String name;
  final double price;
  final String description;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      description: map['description'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
