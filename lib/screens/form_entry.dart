import 'package:flutter/material.dart';
//import 'package:form_user/data/dummy_items.dart';
import 'package:form_user/models/grocery_item.dart';
import 'package:form_user/screens/new_item.dart';

class FormEntry extends StatefulWidget {
  const FormEntry({super.key});

  @override
  State<FormEntry> createState() => _FormEntryState();
}

class _FormEntryState extends State<FormEntry> {
  final List<GroceryItem> _groceryItems = [];
  void _addItems() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your Groceries",
              style: TextStyle(fontFamily: "Gordita")),
          actions: [
            IconButton(
              onPressed: _addItems,
              icon: const Icon(Icons.add),
            )
          ]),
      backgroundColor: const Color.fromARGB(255, 8, 14, 15),
      body: FormMail(
        groceryItems: _groceryItems,
      ),
    );
  }
}

class FormMail extends StatefulWidget {
  const FormMail({super.key, required this.groceryItems});
  final List groceryItems;
  @override
  State<FormMail> createState() => _FormMailState();
}

class _FormMailState extends State<FormMail> {
  void _removeItem(GroceryItem item) {
    setState(() {
      widget.groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
        child: Text('No items added yet.', style: TextStyle(fontSize: 30,color:Colors.white)));

    if (widget.groceryItems.isNotEmpty) {
      content = SizedBox(
          child: ListView.builder(
        itemCount: widget.groceryItems.length,
        itemBuilder: (context, int index) => Dismissible(
          key: ValueKey(widget.groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(widget.groceryItems[index]);
          },
          child: ListTile(
            title: Text(widget.groceryItems[index].name,
                style: const TextStyle(fontFamily: "Gordita")),
            leading: Container(
              width: 30,
              height: 30,
              color: widget.groceryItems[index].category.color,
            ),
            trailing: Text(widget.groceryItems[index].quantity.toString(),
                style: const TextStyle(fontFamily: "Gordita")),
          ),
        ),
      ));
    }

    return content;
  }
}






// ListView.builder(
//           itemCount: groceryItems.length,
//           itemBuilder: (context, int index) => Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(20),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 100,
//                           color: groceryItems[index].category.color,
//                         ),
//                         const SizedBox(
//                           width: 30,
//                         ),
//                         Text("${groceryItems[index].name}",
//                             style: const TextStyle(fontFamily: "Gordita")),
//                         const Spacer(flex: 2),
//                         Text("${groceryItems[index].quantity}",
//                             style: const TextStyle(fontFamily: "Gordita")),
//                       ],
//                     ),
//                   )
//                 ],
//               )),
//     );