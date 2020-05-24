import 'package:bakas/model/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const String routeName = "/product_detail_screen";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              child: Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedProduct.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              tag: 'product$id',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$ ${selectedProduct.price}',
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                selectedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
