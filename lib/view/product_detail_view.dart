import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/viewmodel/cart_viewmodel.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text.dart';
import '../../constants.dart';

class ProductDetailView extends StatelessWidget {
  final ProductModel _productModel;

  ProductDetailView(this._productModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 196.h,
                        width: double.infinity,
                        child: Image.network(
                          _productModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    child: Column(
                      children: [
                        CustomText(
                          text: _productModel.name,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedShapeInfo(
                              title: 'Size',
                              content: CustomText(
                                text: _productModel.size,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                alignment: Alignment.center,
                              ),
                            ),
                            RoundedShapeInfo(
                              title: 'Colour',
                              content: Container(
                                height: 22.h,
                                width: 22.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _productModel.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 33.h,
                        ),
                        CustomText(
                          text: 'Details',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomText(
                          text: _productModel.description,
                          fontSize: 14,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'PRICE',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: '\$${_productModel.price}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                    builder: (controller) => Container(
                      width: 146.w,
                      child: CustomButton('ADD', () {
                        controller.addProduct(
                          CartModel(
                            name: _productModel.name,
                            image: _productModel.image,
                            price: _productModel.price,
                            productId: _productModel.productId,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedShapeInfo extends StatelessWidget {
  final String title;
  final Widget content;

  const RoundedShapeInfo({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 160.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
