
import 'package:flutter/material.dart';
import 'package:flutter_php/modules/http.dart';

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
    var result = await http_get({
      "command": "add_item",
      "name": nameController.text,
    });
    setState(() {
      this.response = result.ok ? (result.data as String) : "Error";
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
