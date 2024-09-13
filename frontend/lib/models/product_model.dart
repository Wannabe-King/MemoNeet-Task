class Product {
  final String id;
  final String name;
  double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as double),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price.toString(),
      };
}
