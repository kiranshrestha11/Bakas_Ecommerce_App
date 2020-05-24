import 'package:bakas/model/orders.dart' show Orders;
import 'package:bakas/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakas/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order_screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orderData[i]),
        itemCount: orderData.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
