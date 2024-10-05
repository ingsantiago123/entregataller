import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';

class StorageService {
  static const String _storageKey = 'products';

  static Future<void> saveProduct(Product product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedProducts = prefs.getStringList(_storageKey) ?? [];
    storedProducts.add(json.encode(product.toMap()));
    await prefs.setStringList(_storageKey, storedProducts);
  }

  static Future<List<Product>> loadProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedData = prefs.getStringList(_storageKey) ?? [];
    return storedData
        .map((e) => Product.fromMap(json.decode(e) as Map<String, dynamic>))
        .toList();
  }
}
