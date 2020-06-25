import 'package:bakas/model/cart_provider.dart';
import 'package:bakas/model/products.dart';
import 'package:bakas/screen/cart_screen.dart';
import 'package:bakas/widgets/app_drawer.dart';
import 'package:bakas/widgets/badge.dart';
import 'package:bakas/widgets/custom_search_delegate.dart';
import 'package:bakas/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const String routeName = "/product_overview";
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  //Products products = new Products();
  bool _showFavourites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bakas"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showFavourites = true;
                } else {
                  _showFavourites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          //consumer only affects the part that needs too
          //rebuild rather than refreshing the whole screen
          Consumer<Cart>(
            builder: (_, cart, child) {
              return cart.itemCount == 0
                  ? child
                  : Badge(
                      child: child,
                      value: cart.itemCount.toString(),
                    );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          )
        ],
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavourites),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
