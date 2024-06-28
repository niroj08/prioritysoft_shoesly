import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prioritysoft_shoesly/products/product_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Obx(
          () => controller.hasInternet.value
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: Text("Hello World"),
                )
              : Lottie.asset('assets/no_internet.json', height: 300.00),
        ),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: controller.hasInternet.value,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Filter',
              child: const Icon(Icons.search),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
