import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/product_item.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List productList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Uri url = Uri.https("dummyjson.com", "products");
    final response = await http.get(url);
    final dataAsJson = json.decode(response.body);

    setState(() {
      productList = dataAsJson["products"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) => ProductItem(
                imgUrl: productList[index]["thumbnail"],
                title: productList[index]["title"],
              )),
    );
  }
}
