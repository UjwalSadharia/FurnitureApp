import 'package:flutter/material.dart';

import '../constants.dart';


class Product{
  int ?id;
  String ?image;
  int ?price;
  String ?title;
  String ?describtion;
  Color ?color;
  Product({
    this.id,
    this.image,
    this.price,
    this.title,
    this.describtion,
    this.color,
  });



}

List<Product>products=[
  Product(
    id: 1,
    image: 'assets/images/Item_1.png',
    price: 2000,
    title: 'Classic Leather Arm Chair',
    describtion: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
    color: Colors.amber,
  ),
  Product(
    id: 2,
    image: 'assets/images/Item_2.png',
    price: 4000,
    title: 'Poppy Plastic Tub Chair',
    describtion: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
    color:defaultColor ,
  ),
  Product(
    id: 3,
    image: 'assets/images/Item_3.png',
    price: 1000,
    title: 'Bar Stool Chair',
    describtion: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
    color: Colors.amber,
  ),
];