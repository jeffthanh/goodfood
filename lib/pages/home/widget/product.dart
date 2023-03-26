import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

import '../../../config/const.dart';
import '../../../providers/product_provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product';
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool change = true;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var product =
        Provider.of<ProductProvider>(context).getItemWithId(arg['id']);
    product.toggleIsSeen();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(product.image),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Positioned(
                      top: 20,
                      left: 20,
                      child: BackButton(
                        color: dColorIconButtonInactive,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                product.toggleIsFavorite();
                                setState(() {
                                  change = !change;
                                });
                              }),
                              child: Icon(
                                Icons.favorite,
                                color: product.isFavorite
                                    ? dColorIconButtonActive
                                    : dColorIconButtonInactive,
                                size: sizeIconButtonTitle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              product.favorite,
                              style: styleTitleIcon,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.timelapse_sharp,
                              color: dColorIconButtonInactive,
                              size: sizeIconButtonTitle,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              product.view,
                              style: styleTitleIcon,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/background/background_product.png'),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(product.intro),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 167,
                          height: 35,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: dColorProduct,
                          ),
                          child: const Center(
                              child: Text(
                            'Nguyên Liệu',
                            style: styleTitleItem,
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: dColorProduct,
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(product.ingredients),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 167,
                          height: 35,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: dColorProduct,
                          ),
                          child: const Center(
                              child: Text(
                            'Cách thực hiện',
                            style: styleTitleItem,
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: dColorProduct,
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(product.instructions),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
