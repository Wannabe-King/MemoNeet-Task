import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final _addProductFormKey = GlobalKey<FormState>();
  final _updatePriceFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch products when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productViewModel.products.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loader while products are being fetched
          : ListView.builder(
              itemCount: productViewModel.products.length,
              itemBuilder: (context, index) {
                print(productViewModel.products);
                final product = productViewModel.products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tileColor: Colors.amber[100],
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            productViewModel
                                .deleteProduct((product.id).toString());
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            double? newPrice = await _showPriceUpdateDialog(
                                context, product.price);
                            if (newPrice != null) {
                              productViewModel.updateProductPrice(
                                  product.id, newPrice);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddProductDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Product',
      ),
    );
  }

  // Show Dialog to Update Price
  Future<double?> _showPriceUpdateDialog(
      BuildContext context, double currentPrice) {
    final TextEditingController priceController =
        TextEditingController(text: currentPrice.toString());

    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Price'),
          content: Form(
            key: _updatePriceFormKey, // Declare a global key for the form
            child: TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'New Price'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                final double? price = double.tryParse(value);
                if (price == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_updatePriceFormKey.currentState!.validate()) {
                  final double newPrice = double.parse(priceController.text);
                  Navigator.of(context).pop(newPrice);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Show Dialog to Add New Product
  Future<void> _showAddProductDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Product'),
          content: Form(
            key: _addProductFormKey, // Declare a global key for the form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Product Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product price';
                    }
                    final double? price = double.tryParse(value);
                    if (price == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_addProductFormKey.currentState!.validate()) {
                  final String name = nameController.text;
                  final double price = double.parse(priceController.text);
                  Provider.of<ProductViewModel>(context, listen: false)
                      .addProduct(name, price);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
