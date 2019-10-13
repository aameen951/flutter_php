import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddItemPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return AddItemPageState();
  }
}
class AddItemPageState extends State<AddItemPage>
{
  TextEditingController nameController = TextEditingController();
  String response = "NULL";
  createItem() async {
    var dataStr = jsonEncode({
      "command": "add_item",
      "name": nameController.text,
    });
    var url = "http://192.168.1.5/flutter_php/index.php?data=" + dataStr;
    var result = await http.get(url);
    setState(() {
      this.response = result.body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: this.nameController,
            decoration: InputDecoration(
              labelText: "Name"
            ),
          ),
          RaisedButton(
            onPressed: createItem,
            child: Text("Create"),
          ),
          Text(this.response),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}
class Item
{
  String id;
  String name;
  DateTime timestamp;
  Item(this.id, this.name, this.timestamp);
}
class MainPageState extends State<MainPage>
{
  List<Item> data = [];
  showAddItemPage()
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return AddItemPage();
    }));
  }
  refreshData() async {
    var dataStr = jsonEncode({
      "command": "get_items",
    });
    var url = "http://192.168.1.5/flutter_php/index.php?data=" + dataStr;
    var result = await http.get(url);
    setState(() {
      data.clear();
      var jsonItems = jsonDecode(result.body) as List<dynamic>;
      jsonItems.forEach((item){
        this.data.add(Item(
          item['id'] as String,
          item['name'] as String,
          DateTime.parse(item['timestamp'] as String)
        ));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showAddItemPage,
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: refreshData,
            child: Text("Refresh"),
          ),
          Column(
            children: data.map((item) => Text(item.name)).toList(),
          ),
        ],
      ),
    );
  }
  
}

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter PHP",
      home: MainPage(),
    );
  }

}

void main() {
  runApp(App());
}