import 'package:flutter/material.dart';
import 'package:project/pages/home/widget/category.dart';

import '../../config/const.dart';
import '../../providers/category_provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CategoryProvider().readJson(),
        builder: (BuildContext content, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var categoryItem = snapshot.hasData ? snapshot.data : [];
          return snapshot.hasData
              ? GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categoryItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CategoryPage.routeName,
                            arguments: {
                              "title": categoryItem[index].name,
                              "categoryId": categoryItem[index].id,
                            });
                      },
                      child: Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage(categoryItem[index].image),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  categoryItem[index].name.toString(),
                                  style: styleTitleItem,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Not Data'),
                );
        });
  }
}
