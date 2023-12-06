import 'dart:convert';
import 'ratings.dart';

class Product {
  final String name;
  final String description;
  final String category;
  final double price;
  final int quantity;
  final List<String> images;
  final List<Ratings>? ratings;
  String? id;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
    this.id,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'quantity': quantity,
      'images': images,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      id: map['_id'],
      ratings: map['ratings'] != null
          ? List<Ratings>.from(
              map['ratings']?.map(
                (x) => Ratings.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(jsonDecode(source));
}
