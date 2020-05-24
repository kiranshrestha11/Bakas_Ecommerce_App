import 'package:bakas/model/cart_provider.dart';
import 'package:bakas/model/orders.dart';
import 'package:bakas/model/products.dart';
import 'package:bakas/screen/cart_screen.dart';
import 'package:bakas/screen/edit_product_screen.dart';
import 'package:bakas/screen/order_screen.dart';
import 'package:bakas/screen/product_detail.dart';
import 'package:bakas/screen/product_overview_screen.dart';
import 'package:bakas/screen/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(value: Orders())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bakas",
          theme: ThemeData(
            primaryColor: Colors.grey[300],
            accentColor: Colors.red,
          ),
          initialRoute: "/",
          routes: {
            "/": (ctx) => ProductOverviewScreen(),
            ProductDetail.routeName: (ctx) => ProductDetail(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
