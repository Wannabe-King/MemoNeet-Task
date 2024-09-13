// import 'package:flutter/foundation.dart';
// import '../models/product_model.dart';
// import '../services/api_service.dart';

// class ProductViewModel extends ChangeNotifier {
//   List<Product> _products = [];

//   List<Product> get products => _products;

//   Future<void> fetchProducts() async {
//     _products = await ApiService.getProducts();
//     notifyListeners();
//   }
// }

// import 'package:flutter/foundation.dart';
// import '../models/product_model.dart';
// import '../services/api_service.dart';

// class ProductViewModel extends ChangeNotifier {
//   List<Product> _products = [];

//   List<Product> get products => _products;

//   Future<void> fetchProducts() async {
//     _products = await ApiService.getProducts();
//     notifyListeners();
//   }

//   // Delete a product by ID
//   void deleteProduct(int id) {
//     _products.removeWhere((product) => product.id == id);
//     notifyListeners();
//     // Optionally, you can add an API call here to update the server if needed
//     // ApiService.deleteProduct(id);
//   }

//   // Update the product price
//   void updateProductPrice(int id, double newPrice) {
//     final product = _products.firstWhere((product) => product.id == id);
//     product.price = newPrice;
//     notifyListeners();
//     // Optionally, you can add an API call here to update the server if needed
//     // ApiService.updateProductPrice(id, newPrice);
//   }
// }

import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await ApiService.getProducts();
    notifyListeners();
  }

  // Delete a product by ID
  void deleteProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
    // Optionally, add API call to delete product on the server
  }

  // Update the product price
  void updateProductPrice(int id, double newPrice) {
    final product = _products.firstWhere((product) => product.id == id);
    product.price = newPrice;
    notifyListeners();
    // Optionally, add API call to update product price on the server
  }

  // Add new product
  void addProduct(String name, double price) {
    final newProduct = Product(id: DateTime.now().millisecondsSinceEpoch, name: name, price: price);
    _products.add(newProduct);
    notifyListeners();
    // Optionally, add API call to add product on the server
  }
}
