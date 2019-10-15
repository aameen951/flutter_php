
import 'package:flutter/material.dart';
import 'package:flutter_php/models/item.dart';
import 'package:flutter_php/modules/http.dart';
import 'package:flutter_php/pages/add_item.dart';
import 'package:flutter_php/pages/view_item.dart';

class MainPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
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

    var result = await http_get({
      "command": "get_items",
    });
    if(result.ok)
    {
      setState(() {
        data.clear();
        var jsonItems = result.data as List<dynamic>;
        jsonItems.forEach((item){
          this.data.add(Item(
            item['id'] as String,
            item['name'] as String,
            DateTime.parse(item['timestamp'] as String)
          ));
        });
      });
    }
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
      body:
      RefreshIndicator(
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(data[i].name),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewItemPage(data[i]),
              ));
            },
          ),
          separatorBuilder: (context, i) => Divider(),
        ),
        onRefresh: () async {await refreshData();},
      ) 
    );
  }
  
}

