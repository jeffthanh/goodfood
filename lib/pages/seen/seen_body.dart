import 'package:flutter/material.dart';
import 'package:project/config/const.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

class SeenBody extends StatelessWidget {
  const SeenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = Provider.of<ProductProvider>(context).getItemsIsSeen();

    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
          value: items[index],
          child: Dismissible(
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete Product'),
                  content: const Text('Are You Sure Delete ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: ((direction) {
              items[index].handleRemoveIsSeen();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Delete success!'),
              ));
            }),
            key: ValueKey<int>(index),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 140,
                child: GridTile(
                  footer: GridTileBar(
                    title: Text(
                      items[index].title,
                      style: styleTitleItem,
                    ),
                    trailing: const Icon(
                      Icons.swipe,
                      size: sizeIconButtonTitle,
                      color: dColorIconButtonInactive,
                    ),
                    backgroundColor: Colors.white70,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(items[index].image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
