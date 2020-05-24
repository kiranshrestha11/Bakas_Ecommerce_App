import 'package:bakas/model/products.dart';
import 'package:bakas/screen/edit_product_screen.dart';
import 'package:bakas/widgets/app_drawer.dart';
import 'package:bakas/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user_product_screen";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (ctx, index) => UserProductItem(
          productsData.items[index].id,
          productsData.items[index].title,
          productsData.items[index].imageUrl,
        ),
        itemCount: productsData.items.length,
      ),
    );
  }
}
