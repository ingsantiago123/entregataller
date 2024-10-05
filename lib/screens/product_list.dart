import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    List<Product> products = await StorageService.loadProducts();
    if (mounted) {
      setState(() {
        _products = products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.white),
      ),
      extendBodyBehindAppBar: true, 
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.pinkAccent],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _products.length,
          itemBuilder: (context, index) {
            Product product = _products[index];
            return Card(
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                title: Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Descripción: ${product.description}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Precio: \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Cantidad: ${product.quantity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
