import 'dart:convert';

import 'package:bakas/helper/custom_route.dart';
import 'package:bakas/provider/auth_provider.dart';
import 'package:bakas/screen/auth_screen.dart';
import 'package:bakas/screen/product_overview_screen.dart';
import 'package:bakas/screen/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:bakas/screen/order_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isInit = true;
  String email = "";
  String userType = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      getUserData();
    }
    isInit = false;
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedData =
        json.decode(prefs.getString("userData")) as Map<String, Object>;
    print(extractedData);
    setState(() {
      email = extractedData["email"];
      userType = extractedData["userType"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Kiran Kumar Shrestha"),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://scontent.fktm1-1.fna.fbcdn.net/v/t1.0-1/p160x160/23722598_1983723755233960_8086614917141637050_n.jpg?_nc_cat=105&_nc_sid=dbb9e7&_nc_ohc=kG1f8V3inhUAX_dQnY-&_nc_ht=scontent.fktm1-1.fna&_nc_tp=6&oh=1bc26224ac241069f2f8a1a1f382b3f3&oe=5EED3069"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              //Navigator.pushReplacementNamed(context, OrderScreen.routeName);
              Navigator.of(context).pushReplacement(
                  CustomRoute(builder: (ctx) => OrderScreen()));
            },
          ),
          Divider(),
          userType == "client"
              ? Container()
              : Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Manage Products'),
                      onTap: () {
//              Navigator.pushReplacementNamed(
//                  context, UserProductScreen.routeName);
                        Navigator.of(context).pushReplacement(
                            CustomRoute(builder: (ctx) => UserProductScreen()));
                      },
                    ),
                    Divider(),
                  ],
                ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
