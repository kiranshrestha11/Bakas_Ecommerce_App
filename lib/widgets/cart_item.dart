import 'package:bakas/model/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String id;
  final double price;
  final int quantity;
  final String productId;

  CartItem({this.title, this.id, this.price, this.quantity, this.productId});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(DateTime.now()),
      onDismissed: (direction) {
        cart.removeFromCart(productId);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Are you Sure?"),
              content: Text("Do you want to remove from the cart?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(child: Text("\$ $price")),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total Price: \$ ${price * quantity}"),
            trailing: Text("$quantity X"),
          ),
        ),
      ),
    );
  }
}
