import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

class ProductForm extends StatefulWidget {
  final VoidCallback onProductSaved;

  const ProductForm({super.key, required this.onProductSaved});

  @override
  State<ProductForm> createState() => ProductFormState();
}

class ProductFormState extends State<ProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _saveProduct() async {
    final String name = _nameController.text;
    final double? price = double.tryParse(_priceController.text);
    final String description = _descriptionController.text;
    final int? quantity = int.tryParse(_quantityController.text);

    if (name.isNotEmpty &&
        price != null &&
        description.isNotEmpty &&
        quantity != null) {
      Product newProduct = Product(
        name: name,
        price: price,
        description: description,
        quantity: quantity,
      );
      try {
        await StorageService.saveProduct(newProduct);
        if (mounted) {
          widget.onProductSaved(); 
        }
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    } else {
      _showErrorDialog('Todos los campos son obligatorios y deben ser válidos.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
  
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.text_fields, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  prefixIcon: Icon(Icons.description, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  prefixIcon: Icon(Icons.format_list_numbered, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Guardar'),
                style: ElevatedButton.styleFrom(
            
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
