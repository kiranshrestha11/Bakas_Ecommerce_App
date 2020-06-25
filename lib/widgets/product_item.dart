import 'package:bakas/model/cart_provider.dart';
import 'package:bakas/model/product.dart';
import 'package:bakas/provider/auth_provider.dart';
import 'package:bakas/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetail.routeName,
                arguments: loadedProduct.id);
          },
          child: Hero(
            tag: 'product${loadedProduct.id}',
            child: FadeInImage(
              placeholder: AssetImage("assets/images/loading.gif"),
              image: NetworkImage(
                loadedProduct.imageUrl,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black26,
          title: Text(
            loadedProduct.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (_, product, child) {
              return IconButton(
                icon: Icon(
                  loadedProduct.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white54,
                ),
                onPressed: () {
                  loadedProduct.toggleIsFavourite(auth.userId, auth.token);
                },
                color: Theme.of(context).accentColor,
              );
            },
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white54,
            ),
            onPressed: () {
              cart.addToCart(
                  loadedProduct.id, loadedProduct.price, loadedProduct.title);
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Text('Added item to the cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    textColor: Colors.black,
                    onPressed: () {
                      cart.removeSingleItem(loadedProduct.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
