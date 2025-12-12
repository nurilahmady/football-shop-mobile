// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.round();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

bool _toBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) return value.toLowerCase() == 'true' || value == '1';
  return false;
}

class ProductEntry {
  String id;
  String name;
  int price;
  String description;
  String category;
  String thumbnail;
  bool isFeatured;
  int stock;
  String brand;
  int rating;
  DateTime createdAt;
  int userId;
  String ownerUsername;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.isFeatured,
    required this.stock,
    required this.brand,
    required this.rating,
    required this.createdAt,
    required this.userId,
    required this.ownerUsername,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: (json["id"] ?? '').toString(),
        name: json["name"] ?? '',
        price: _toInt(json["price"]),
        description: json["description"] ?? '',
        category: json["category"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        isFeatured: _toBool(json["is_featured"]),
        stock: _toInt(json["stock"]),
        brand: json["brand"] ?? '',
        rating: _toInt(json["rating"]),
        createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        userId: _toInt(json["user_id"]),
        ownerUsername: json["owner_username"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "user_id": userId,
        "owner_username": ownerUsername,
      };
}
