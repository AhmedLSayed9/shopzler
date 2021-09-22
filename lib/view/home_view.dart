import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/viewmodel/checkout_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import 'category_products_view.dart';
import 'product_detail_view.dart';
import 'search_view.dart';
import 'widgets/custom_text.dart';
import '../../constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());

    return Scaffold(
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 65.h, bottom: 14.h, right: 16.w, left: 16.w),
                child: Column(
                  children: [
                    Container(
                      height: 49.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(45.r),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          Get.to(SearchView(value));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    CustomText(
                      text: 'Categories',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    ListViewCategories(),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Best Selling',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(CategoryProductsView(
                              categoryName: 'Best Selling',
                              products: controller.products,
                            ));
                          },
                          child: CustomText(
                            text: 'See all',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ListViewProducts(),
                  ],
                ),
              ),
      ),
    );
  }
}

class ListViewCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 90.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductsView(
                  categoryName: controller.categories[index].name,
                  products: controller.products
                      .where((product) =>
                          product.category ==
                          controller.categories[index].name.toLowerCase())
                      .toList(),
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white,
                      ),
                      height: 60.h,
                      width: 60.w,
                      child: Padding(
                        padding: EdgeInsets.all(14.h),
                        child: Image.network(
                          controller.categories[index].image,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    text: controller.categories[index].name,
                    fontSize: 12,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 20.w,
            );
          },
        ),
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  ProductDetailView(controller.products[index]),
                );
              },
              child: Container(
                width: 164.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Colors.white,
                      ),
                      height: 240.h,
                      width: 164.w,
                      child: Image.network(
                        controller.products[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      text: '\$${controller.products[index].price}',
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15.w,
            );
          },
        ),
      ),
    );
  }
}
