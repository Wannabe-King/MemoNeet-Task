import '../services/api_service.dart';
import '../models/product_model.dart';

class GroceryRepository {
  Future<List<Product>> fetchProducts() => ApiService.getProducts();
}
