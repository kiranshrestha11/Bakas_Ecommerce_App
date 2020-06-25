import 'package:bakas/model/products.dart';
import 'package:bakas/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  //Products products = new Products();
  final bool showFavourites;
  ProductGrid(this.showFavourites);

  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<Products>(context);
    final products =
        showFavourites ? loadedProducts.favourites : loadedProducts.items;
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, index) => Consumer<Products>(
        builder: (key, builder, _) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          );
        },
      ),
    );
  }
}
