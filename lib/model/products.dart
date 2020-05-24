import 'package:bakas/model/product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: "1",
      title: "Watch",
      price: 2000,
      description: "The best watch that fits both classy and modern look",
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/81BDpSIwu3L._UL1500_.jpg",
      isFavourite: false,
    ),
    Product(
      id: "2",
      title: "Phone",
      price: 5000,
      description: "The best phone that fits both classy and modern look",
      isFavourite: false,
      imageUrl:
          "https://www.powerplanetonline.com/cdnassets/xiaomi_redmi_8a_2gb_32gb_01_m.jpg",
      //isFavourite: false,
    ),
    Product(
        id: "3",
        title: "T-Shirt",
        price: 1000,
        description: "The best watch that fits both classy and modern look",
        isFavourite: false,
        imageUrl:
            "https://rukminim1.flixcart.com/image/704/704/jflfgcw0/t-shirt/x/6/s/m-mischief-harry-potter-tshirts-original-imaf4yy9xh9ygsgg.jpeg?q=70"),
    Product(
      id: "4",
      title: "Shoe",
      price: 2000,
      description: "The best shoe that fits both classy and modern look",
      isFavourite: false,
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/61utX8kBDlL._UL1100_.jpg",
    ),
    Product(
        id: "5",
        title: "TV",
        price: 25000,
        description: "4K Curved Display",
        imageUrl:
            "https://www.starmac.co.ke/wp-content/uploads/2019/08/samsung-65-inch-ultra-4k-curved-tv-ua65ku7350k-series-7.jpg",
        isFavourite: false),
  ];

  List<Product> get items {
    return [..._items];
  }

//show only favourite item
  List<Product> get favourites {
    return _items.where((prodItem) {
      return prodItem.isFavourite;
    }).toList();
  }

//find the selectedproduct by using id
  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  //this function adds new product
  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  //this function updates the current product
  void updateProduct(String id, Product upProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = upProduct;
      notifyListeners();
    }
  }

  //this functions delete the current product
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
