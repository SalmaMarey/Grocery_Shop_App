import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/data/categories.dart';

import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/grocery_item.dart';
import 'package:shop_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;

  String? _error;
  void _loadData() async {
    final Uri url = Uri.https(
        'shop-f691e-default-rtdb.firebaseio.com', 'shopping=list.json');
    try {
      final http.Response res = await http.get(url);
      if (res.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
        return;
      }
      if (res.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> loadedData = json.decode(res.body);
      final List<GroceryItem> loadedItems = [];

      for (var item in loadedData.entries) {
        // print(item.value);
        final Category category = categories.entries
            .firstWhere(
              (element) => element.value.title == item.value['category'],
            )
            .value;
        loadedItems.add(
          GroceryItem(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category),
        );
        setState(() {
          _groceryItems = loadedItems;
          _isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        _error = 'Somthing went wrong. Please try again later.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            child: Image.asset('assets/1.png')),
        const SizedBox(
          height: 100,
        ),
        const Text(
          'No item added yet!',
          style: TextStyle(fontSize: 25),
        ),
      ]),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          // key: ValueKey(_groceryItems[index].id),
          onDismissed: (_) {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('Are you sure you want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _removeItem(_groceryItems[index]);
                            Navigator.pop(ctx);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(ctx);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ));
          },

          child: Padding(
            padding: const EdgeInsets.all(.8),
            child: Card(
              color: const Color(0xFF494B50),
              child: ListTile(
                title: Text(_groceryItems[index].name),
                leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.network(
                    _groceryItems[index].category.imageUrl,
                  ),
                ),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            ),
          ),
        ),
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  'assets/2.png',
                  width: 40,
                  height: 40,
                )),
            const Text(
              'Your Grocery',
              style: TextStyle(color: Colors.white),
            ),
          ]),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(padding: const EdgeInsets.only(top: 8), child: content));
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final Uri url = Uri.https('shop-f691e-default-rtdb.firebaseio.com',
        'shopping=list/${item.id}.json');
    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('We could not delete the item.')));
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  _addItem() async {
    final newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });

    // _loadData();
  }
}
