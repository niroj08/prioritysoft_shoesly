import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prioritysoft_shoesly/products/product_controller.dart';
import 'package:prioritysoft_shoesly/repository/model/product.dart';
import 'package:prioritysoft_shoesly/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget productItemWidget(ProductItem item) {
  ProductController controller = Get.find<ProductController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(16.0),
        height: 44.w,
        width: 44.w,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 20.0,
                width: 20.0,
                child: Image.asset(
                  controller.getBrandImage(item.brand!),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(controller.getProductImage(item.brand!)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      Text(
        item.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: ShoeslyTextTheme.bodyText100,
      ),
      const SizedBox(height: 4.0),
      Row(
        children: [
          const Icon(
            Icons.star,
            size: 14.0,
            color: Colors.yellow,
          ),
          const SizedBox(
            width: 2.0,
          ),
          Text(
            "${item.rating!}",
            style: ShoeslyTextTheme.bodyText10
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 2.0,
          ),
          Text(
            " (${item.reviews!} reviews)",
            style: ShoeslyTextTheme.bodyText10.copyWith(color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 4.0),
      Text(
        "\$${item.price!}",
        style: ShoeslyTextTheme.headline300,
      ),
    ],
  );
}
