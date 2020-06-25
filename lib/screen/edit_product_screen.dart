import 'package:bakas/model/product.dart';
import 'package:bakas/model/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product_screen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isInit = true;
  bool _isLoading = false;

  var _editedProduct = Product(
    id: null,
    title: "",
    price: 0,
    description: "",
    imageUrl: "",
  );

  var initValues = {
    'title': "",
    'price': "",
    'description': "",
    'imageUrl': "",
  };

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': _editedProduct.imageUrl
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  //========to update image on container
  void _updateImageUrl() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLFocusNode.dispose();
    _imageUrlController.dispose();
  }

  // save form and validate
  Future<void> _saveForm() async {
    final isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }

    _form.currentState.save();
    //loading occurs
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occured'),
            content: Text('Product Could not be added due to some issue.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occured'),
            content: Text('Product Could not be added due to some issue.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    //after process finishes
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _editedProduct.id != null
            ? Text("Edit Product")
            : Text("Add Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Title must not be empty";
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value.trim(),
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['price'],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: "Price"),
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Price must not be empty";
                        }
                        if (double.tryParse(value) == null) {
                          return "Price must be number only";
                        }
                        if (double.parse(value) <= 0) {
                          return "Price must be less than Zero";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(value),
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['description'],
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: "Description"),
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Description must not be empty";
                        }
                        if (value.length < 5) {
                          return "Description must be at least 10 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: value.trim(),
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 15, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: _imageUrlController.text.isEmpty
                              ? FittedBox(
                                  child: Text("Enter a image URL"),
                                )
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageURLFocusNode,
                            decoration: InputDecoration(labelText: "ImageUrl"),
                            controller: _imageUrlController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "ImageUrl must not be empty";
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return "ImageUrl is not valid";
                              }
                              if (!value.endsWith('.jpg') &&
                                  !value.endsWith('.png') &&
                                  !value.endsWith('.jpeg')) {
                                return "Provided Url is not in correct format";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                id: _editedProduct.id,
                                imageUrl: value.trim(),
                                price: _editedProduct.price,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
