import 'package:flutter/material.dart';

import 'dart:convert' as convert;	
import 'package:http/http.dart' as http;
//import 'functions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridge list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _fridges = [];

  Future<void> requestFridges() async {
    List<String> list = [];
    try {
      var url = Uri.parse('http://192.168.0.12:5000/fridges');
      var r = await http.get(url);
      var data = convert.jsonDecode(r.body);
      for (var fridge in data) {
      list.add(fridge["location"]);
    }
    _fridges = list;
    //print(_fridges);
    } catch (_) {
      //print("FUCK");
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    //TODO : Why does it take so damn long to get the data from the request?
    requestFridges();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Fridges')),
    body:
      ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          height: 0,
        ),
        padding: const EdgeInsets.only(left: 5, right: 5),
        shrinkWrap: true,
        itemCount: _fridges.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.lightBlueAccent[100],
          child: Center(child: Text(_fridges[index])),
          );
        }
      )
    );
  }
}

class FridgeListPage extends StatefulWidget{

  final List<String> fridges;
  const FridgeListPage({Key? key, required this.fridges}) : super(key:key);

  @override
  State<FridgeListPage> createState() => _FridgeListPageState();
}

class _FridgeListPageState extends State<FridgeListPage> {
  //Variables
  final location = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  //View
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Empty List Test')),
    body:
      ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.fridges.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.lightBlue[200],
          child: Center(child: Text(widget.fridges[index])),
          );
        }
      )
    );
  }
}

