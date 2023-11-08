import 'package:flutter/material.dart';

import 'drink.dart';

class BubbleTeaShop extends ChangeNotifier {
  //list of drink for sale
  final List<Drink> _shop = [
    //pearl milk tea
    Drink(
      name: "ชาไทย ",
      price: "35.00",
      imagePath: "lib/images/milk_tea.png",
    ),
    Drink(
      name: "กาแฟ ☕",
      price: "30.00",
      imagePath: "lib/images/coffee.jpg",
    ),
    Drink(
      name: "ชาเขียว 🍵",
      price: "40.00",
      imagePath: "lib/images/green_tea.png",
    ),
    Drink(
      name: "นมชมพู",
      price: "35.00",
      imagePath: "lib/images/pink_milk.png",
    ),
  ];

  //list of drink in user cart
  final List<Drink> _userCart = [];

  //get drink for sale
  List<Drink> get shop => _shop;

  //get user cart
  List<Drink> get cart => _userCart;

  //add drink to cart
  void addToCart(Drink drink) {
    _userCart.add(drink);
    notifyListeners();
  }

  //remove drink from cart
  void removeFromeCart(Drink drink) {
    _userCart.remove(drink);
    notifyListeners();
  }
}
