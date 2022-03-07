//import 'dart:html';
//import 'dart:io';
import 'dart:async';
//import 'dart:html';
//import 'dart:convert';
//import 'dart:developer';
//import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'fridge.dart';
import 'item.dart';

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
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/items': (context) => const ItemList()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _pageSize = 10;
  static const _biggerFont =
      TextStyle(fontSize: 18.0, color: Color(0xFF0D47A1));

  final PagingController<int, Fridge> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await requestFridges();
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Fridges')), body: _buildList());
  }

  Widget _buildList() => PagedListView<int, Fridge>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Fridge>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => ListTile(
            title: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/items',
                  arguments: {
                    "fridgeId": item.fridgeId,
                    "location": item.location
                  }),
              child: Text(item.location, style: _biggerFont),
            ),
            tileColor: Colors.lightBlue[100],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          height: 5,
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  static const _pageSize = 10;
  static const _biggerFont =
      TextStyle(fontSize: 18.0, color: Color(0xFF0D47A1));

  final PagingController<int, Item> _pagingController =
      PagingController(firstPageKey: 0);

  late Map arguments;
  late int fridgeId;
  late String location;

  //List<Item>? _itemList;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

//  void _refreshList() async {
//    _itemList = await requestItem(fridgeId);
//    _pagingController.refresh();
//  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await requestItem(fridgeId);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //Future<void> _fetchPage(int pageKey) async {
  //  try{
  //    if (_itemList == null) _refreshList();
//
  //    int size = _itemList!.length;
  //    final isLastPage = size <= pageKey + _pageSize;
//
  //    List<Item> newItems = List.from(_itemList!.getRange(pageKey, isLastPage ? size : pageKey + _pageSize));
  //    if (isLastPage) {
  //      _pagingController.appendLastPage(newItems);
  //    }
  //    else{
  //      final nextPageKey = pageKey + newItems.length;
  //      _pagingController.appendPage(newItems, nextPageKey);
  //    }
  //  }
  //  catch(error){
  //    _pagingController.error = error;
  //  }
  //}

//  @override
//  Widget build(BuildContext context){
//    arguments = ModalRoute.of(context)!.settings.arguments as Map;
//    fridgeId = arguments['fridgeId'];
//    location = arguments['location'];
//  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as Map;
    fridgeId = arguments['fridgeId'];
    location = arguments['location'];
    return Scaffold(
        appBar: AppBar(title: const Text('Items')), body: _buildList());
  }

  Widget _buildList() => PagedListView<int, Item>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Item>(
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => ListTile(
            title: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/items_info',
                  arguments: {
                    "fridgeId": item.fridgeId,
                    "itemId": item.itemId
                  }),
              child: Text(item.i_name, style: _biggerFont),
            ),
            tileColor: Colors.lightBlue[100],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          height: 5,
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
