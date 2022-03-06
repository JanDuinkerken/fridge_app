//import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

//import 'dart:io';
import 'dart:async';
import 'dart:convert';
//import 'dart:developer';
//import 'dart:math' as math;

import 'package:http/http.dart' as http;

class Item{
  Item({required this.fridgeId, required this.itemId, required this.cuantity, required this.date, required this.i_name, required this.drawer});

  final int fridgeId;
  final int itemId;
  final int cuantity;
  final String date;
  final String i_name;
  final int drawer;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(fridgeId: json["fridgeId"], itemId: json["itemId"], cuantity:json["cuantity"], date:json["r_date"], i_name:json["i_name"], drawer: json["drawer"]);
  }
}

Future<List<Item>> requestItem(int fId) async {
  var url = Uri.parse('http://192.168.0.12:5000/fridges/${fId.toString()}');
  var r = await http.get(url);
  List<Item> list = [];
  if (r.statusCode == 200) {
    var json = jsonDecode(r.body);
    for (var item in json) {
      list.add(Item.fromJson(item));
    }
  } else {
    throw ("Database error");
  }
  return list;
}

void createItem(String i_name, int fId, int cuantity, int drawer) async{
  var url = Uri.parse('http://192.168.0.12:5000/fridges/${fId.toString()}');
  final r = await http.post(
    url,
    body: jsonEncode(<String, dynamic>{
      "i_name": i_name,
      "cuantity": cuantity,
      "drawer": drawer
    }),
  );

  if (r.statusCode != 200) {
    throw("Error creating new item: ${r.reasonPhrase}");
  }
}

void updateItem(String i_name, int iId, int fId, int cuantity, int drawer) async{
  var url = Uri.parse('http://192.168.0.12:5000/fridges/${fId.toString()}/${iId.toString()}');
  final r = await http.put(
    url,
    body: jsonEncode(<String, dynamic>{
      "i_name": i_name,
      "cuantity": cuantity,
      "drawer": drawer
    }),
  );

  if (r.statusCode != 200) {
    throw("Error updating item: ${r.reasonPhrase}");
  }
}