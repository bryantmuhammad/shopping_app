import 'package:flutter/material.dart';
import 'package:shopping_app/data/dummy_items.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _changeScreen() async {
    final GroceryItem? newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = const Center(
      child: Text('No groceries items'),
    );

    if (_groceryItems.isNotEmpty) {
      activeWidget = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: ValueKey(_groceryItems[index]),
          onDismissed: (direction) {
            setState(() {
              _groceryItems.removeAt(index);
            });
          },
          child: ListTile(
            leading: Container(
              width: 16,
              height: 16,
              color: _groceryItems[index].category.color,
            ),
            title: Text(_groceryItems[index].name),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: _changeScreen,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: activeWidget);
  }
}
