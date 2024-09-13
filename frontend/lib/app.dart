import 'package:flutter/material.dart';
import 'views/product_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListView(),
    );
  }
}
