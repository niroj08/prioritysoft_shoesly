import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prioritysoft_shoesly/products/product_controller.dart';
import 'package:prioritysoft_shoesly/utils/constants.dart';
import 'package:prioritysoft_shoesly/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.hasInternet.value
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 20.0),
                child: controller.isCollecitonLoading.value
                    ? const Center(
                        child: SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                            )),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Constants.discover,
                                style: ShoeslyTextTheme.headline700,
                              ),
                              const Icon(Icons.shopping_bag_outlined)
                            ],
                          ),
                          ChipsChoice<int>.single(
                            padding: const EdgeInsets.only(top: 20.0),
                            value: controller.tag.value,
                            onChanged: (val) {
                              controller.tag.value = val;
                            },
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: controller.brandValue,
                              value: (i, v) => i,
                              label: (i, v) => v,
                              tooltip: (i, v) => v,
                            ),
                            choiceCheckmark: false,
                            choiceLabelBuilder: (item, i) {
                              return Text(
                                item.label,
                                style: ShoeslyTextTheme.headline600.copyWith(
                                    color: controller.tag.value == i
                                        ? Colors.black
                                        : Colors.black26),
                              );
                            },
                            choiceStyle: C2ChipStyle.outlined(
                              borderStyle: BorderStyle.none,
                              selectedStyle: const C2ChipStyle(
                                borderColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Flexible(
                            child: GridView.builder(
                              shrinkWrap: true,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      height: 44.w,
                                      width: 44.w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24))),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: Image.asset(
                                                'assets/brands/Name=Adidas, Color=Grey.png',
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                                'assets/product_images/Dummy=1, Brand=Nike, Size=Normal.png'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      'Title',
                                      style: ShoeslyTextTheme.bodyText100,
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 10.0,
                                          color: Colors.yellow,
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          '4.5',
                                          style: ShoeslyTextTheme.headline300,
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          '(1045 Reviews)',
                                          style: ShoeslyTextTheme.bodyText100
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '235.00',
                                      style: ShoeslyTextTheme.headline300,
                                    ),
                                  ],
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 2 / 3.3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                            ),
                          ),
                        ],
                      ),
              )
            : Lottie.asset('assets/no_internet.json', height: 300.00),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: controller.hasInternet.value &&
                !controller.isCollecitonLoading.value,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        Constants.filter.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
