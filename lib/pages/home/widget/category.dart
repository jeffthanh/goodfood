import 'package:flutter/material.dart';
import 'package:project/pages/home/widget/product.dart';
import 'package:provider/provider.dart';

import '../../../config/const.dart';
import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import 'category_body.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    var products = Provider.of<ProductProvider>(context)
        .getItemsWithCategoryId(data['categoryId']);
    print(products);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dColorMain,
        title: Text(
          data['title'],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (() {
              Navigator.pushNamed(context, ProductPage.routeName,
                  arguments: {"id": products[index].id});
            }),
            child: ChangeNotifierProvider<Product>.value(
              value: products[index],
              child: const CategoryBody(),
            ),
          );
        },
      ),
    );
  }
}
