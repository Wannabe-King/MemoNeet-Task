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
  void deleteProduct(String id) async {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
    try {
      print(id);
      await ApiService.deleteProduct(
          int.parse(id)); // Call API to delete the product
    } catch (e) {
      // Handle error (e.g., log the error, show a message)
      print('Failed to delete product: $e');
    }
  }

  // Update the product price
  void updateProductPrice(String id, double newPrice) async {
    final product = _products.firstWhere((product) => product.id == id);
    product.price = newPrice;
    notifyListeners();
    try {
      print(id);
      await ApiService.updateProductPrice(
          int.parse(id), newPrice); // Call API to update price
    } catch (e) {
      // Handle error (e.g., log the error, show a message)
      print('Failed to update product price: $e');
    }
  }

  // Add new product
  void addProduct(String name, double price) async{
    final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        price: price);
    _products.add(newProduct);
    notifyListeners();
    try{
      final addedProduct = await ApiService.addProduct(newProduct);
    }catch (e) {
      print('Failed to add product: $e');
    }
    // Optionally, add API call to add product on the server
  }
}
