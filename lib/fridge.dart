//import 'package:flutter/material.dart';

//import 'dart:io';
import 'dart:async';
import 'dart:convert';
//import 'dart:developer';
//import 'dart:math' as math;

import 'package:http/http.dart' as http;

class Fridge {
  Fridge({required this.location, required this.fridgeId});

  final String location;
  final int fridgeId;

  factory Fridge.fromJson(Map<String, dynamic> json) {
    return Fridge(location: json["location"], fridgeId: json["fridgeId"]);
  }
}

Future<List<Fridge>> requestFridges() async {
  var url = Uri.parse('http://192.168.0.12:5000/fridges');
  var r = await http.get(url);
  List<Fridge> list = [];
  if (r.statusCode == 200) {
    var json = jsonDecode(r.body);
    for (var fridge in json) {
      list.add(Fridge.fromJson(fridge));
    }
  } else {
    throw ("Database error");
  }

  return list;
}

void createFridge(String location) async{
  var url = Uri.parse('http://192.168.0.12:5000/fridges');
  final r = await http.post(
    url,
    body: jsonEncode(<String, dynamic>{
      "location": location
    }),
  );

  if (r.statusCode != 200) {
    throw("Error creating new fridge: ${r.reasonPhrase}");
  }
}

void updateFridge(String location, int fridgeId) async{
  var url = Uri.parse('http://192.168.0.12:5000/fridges/${fridgeId.toString()}');
  final r = await http.put(
    url,
    body: jsonEncode(<String, dynamic>{
      "location": location
    })
  );

  if (r.statusCode != 200) {
    throw ("Error updating fridge: ${r.reasonPhrase}");
  }
}