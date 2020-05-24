import 'package:bakas/screen/cart_screen.dart';
import 'package:bakas/screen/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:bakas/screen/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Kiran Kumar Shrestha"),
            accountEmail: Text('kiranstha1679@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://scontent.fktm1-1.fna.fbcdn.net/v/t1.0-1/p160x160/23722598_1983723755233960_8086614917141637050_n.jpg?_nc_cat=105&_nc_sid=dbb9e7&_nc_ohc=kG1f8V3inhUAX_dQnY-&_nc_ht=scontent.fktm1-1.fna&_nc_tp=6&oh=1bc26224ac241069f2f8a1a1f382b3f3&oe=5EED3069"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserProductScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
