import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prioritysoft_shoesly/products/product_controller.dart';
import 'package:prioritysoft_shoesly/repository/model/product.dart';
import 'package:prioritysoft_shoesly/utils/constants.dart';
import 'package:prioritysoft_shoesly/utils/styles.dart';
import 'package:prioritysoft_shoesly/utils/widgets.dart';
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
                padding:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                              const ImageIcon(
                                  AssetImage('assets/icons/cart.png')),
                            ],
                          ),
                          ChipsChoice<int>.single(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 0.0),
                            value: controller.tag.value,
                            onChanged: (val) {
                              controller.onChangedBrandSelection(val);
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
                                style: GoogleFonts.nunito(
                                    color: controller.tag.value == i
                                        ? Colors.black
                                        : Colors.black26,
                                    fontSize: 20.px,
                                    fontWeight: FontWeight.w600),
                              );
                            },
                            choiceStyle: C2ChipStyle.outlined(
                              borderStyle: BorderStyle.none,
                              padding: EdgeInsets.zero,
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
                              itemCount: controller.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                ProductItem item = controller.products[index];
                                return productItemWidget(item);
                              },
                              padding: const EdgeInsets.only(
                                  bottom: 80.0, top: 20.0),
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
            : Center(
                child: Lottie.asset('assets/animations/no_internet.json',
                    height: 300.00)),
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
                      Image.asset(
                        'assets/icons/filter.png',
                        height: 24.0,
                        width: 24.0,
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
