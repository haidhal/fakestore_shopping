import 'package:hive_flutter/adapters.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? image;
  @HiveField(4)
  String? rating;
  @HiveField(5)
  int? qny;
  CartModel({
    required this.id,
    required this.image,
    required this.price,
    required this.rating,
    required this.title,
    this.qny = 1,
  });
}
