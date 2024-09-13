

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../viewmodels/product_viewmodel.dart';
// import '../models/product_model.dart';

// class ProductListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productViewModel = context.watch<ProductViewModel>();

//     return Scaffold(
//       appBar: AppBar(title: Text('Products')),
//       body: ListView.builder(
//         itemCount: productViewModel.products.length,
//         itemBuilder: (context, index) {
//           final product = productViewModel.products[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text('\$${product.price}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Delete Product Button
//                 IconButton(
//                   icon: Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     productViewModel.deleteProduct(product.id);
//                   },
//                 ),
//                 // Update Price Button
//                 IconButton(
//                   icon: Icon(Icons.edit, color: Colors.blue),
//                   onPressed: () async {
//                     double? newPrice = await _showPriceUpdateDialog(context, product.price);
//                     if (newPrice != null) {
//                       productViewModel.updateProductPrice(product.id, newPrice);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Show Dialog to Update Price
//   Future<double?> _showPriceUpdateDialog(BuildContext context, double currentPrice) {
//     final TextEditingController priceController = TextEditingController(text: currentPrice.toString());

//     return showDialog<double>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Price'),
//           content: TextField(
//             controller: priceController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: 'New Price'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final double? newPrice = double.tryParse(priceController.text);
//                 Navigator.of(context).pop(newPrice);
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ListView.builder(
        itemCount: productViewModel.products.length,
        itemBuilder: (context, index) {
          final product = productViewModel.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    productViewModel.deleteProduct(product.id);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    double? newPrice =
                        await _showPriceUpdateDialog(context, product.price);
                    if (newPrice != null) {
                      productViewModel.updateProductPrice(product.id, newPrice);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      // Floating Action Button to Add New Product
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
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'New Price'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double? newPrice = double.tryParse(priceController.text);
                Navigator.of(context).pop(newPrice);
              },
              child: Text('Update'),
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
          title: Text('Add New Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String name = nameController.text;
                final double? price = double.tryParse(priceController.text);
                if (name.isNotEmpty && price != null) {
                  Provider.of<ProductViewModel>(context, listen: false)
                      .addProduct(name, price);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
