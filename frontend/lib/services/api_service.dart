import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String apiUrl = 'http://10.0.2.2:3000';

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/products'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/products/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }

  static Future<void> updateProductPrice(int id, double newPrice) async {
    final response = await http.put(
      Uri.parse('$apiUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'price': newPrice}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product price');
    }
  }

  static Future<Product> addProduct(Product product) async {
    print(product.price);
    final response = await http.post(
      Uri.parse('$apiUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': product.id,
        'name': product.name,
        'price': product.price
      }),
    );
    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }
}
