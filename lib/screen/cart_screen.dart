import 'package:bakas/model/cart_provider.dart' show Cart;
import 'package:bakas/model/orders.dart';
import 'package:bakas/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$ ${cart.totalAmount}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      if (cart.items.isNotEmpty || cart.totalAmount != 0) {
                        order.addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (context, index) => CartItem(
                      title: cart.items.values.toList()[index].title,
                      id: cart.items.values.toList()[index].id,
                      price: cart.items.values.toList()[index].price,
                      quantity: cart.items.values.toList()[index].quantity,
                      productId: cart.items.keys.toList()[index],
                    )),
          )
        ],
      ),
    );
  }
}
