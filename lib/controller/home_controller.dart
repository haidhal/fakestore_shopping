import 'dart:developer';

import 'package:fakestore_shopping/model/cart_model.dart';
import 'package:fakestore_shopping/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class HomeController with ChangeNotifier {
  List<ProductModel> prodData = [];
  bool isLoading = false;
  bool isCartAdd = false;
  List<CartModel> cartData = [];
  List hiveKey = [];

  bool isCart(bool value) {
    isCartAdd = !value;
    notifyListeners();
    log(isCartAdd.toString());
    return isCartAdd;
  }

  getAllProduct() async {
    log('jj');

    try {
      var res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (res.statusCode == 200) {
        prodData = productModelFromJson(res.body);
        isLoading = true;
        notifyListeners();
        // log(prodData[10].title.toString());
      } else {
        log(res.statusCode.toString());
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  cartAdd(CartModel cartmodel) async {
    var box = Hive.box<CartModel>('cart_products');
    try {
      await box.add(cartmodel);
      log('Add Success');
    } catch (e) {
      log(e.toString());
    }
  }

  getCartData() async {
    var box = Hive.box<CartModel>('cart_products');
    cartData = box.values.toList();
    hiveKey = box.keys.toList();

    notifyListeners();
    log(cartData[5].title.toString());
  }

  delectCart(int index) {
    var box = Hive.box<CartModel>('cart_products');
    box.delete(hiveKey[index]);
    getCartData();
  }

  qntUpdate(int index, CartModel cartModel) async {
    var box = Hive.box<CartModel>('cart_products');
    await box.putAt(index, cartModel);
    getCartData();
  }
}
