
import 'package:flutter/material.dart';
import 'package:flutter_php/models/item.dart';
import 'package:flutter_php/modules/http.dart';

class ViewItemPage extends StatelessWidget
{
  final Item item;
  ViewItemPage(this.item);
  deleteItem(BuildContext context) async {
    http_get({
      "command": "delete_item",
      "id": item.id,
    });
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body:Center(
        child: Column(
          children: <Widget>[
            Text("Id: " + item.id),
            RaisedButton(
              color: Colors.red,
              onPressed: (){deleteItem(context);},
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
