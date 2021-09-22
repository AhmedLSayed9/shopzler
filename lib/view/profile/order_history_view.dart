import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../core/viewmodel/checkout_viewmodel.dart';
import '../widgets/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Order History',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CheckoutViewModel>(
              init: Get.find<CheckoutViewModel>(),
              builder: (controller) => ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: controller.checkouts[index].date,
                                    color: Colors.grey,
                                  ),
                                  CustomText(
                                    text: 'Pending',
                                    color: Colors.red.shade300,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              ),
                              CustomText(
                                text: controller.checkouts[index].street,
                              ),
                              CustomText(
                                text: controller.checkouts[index].city,
                              ),
                              CustomText(
                                text: controller.checkouts[index].state,
                              ),
                              CustomText(
                                text: controller.checkouts[index].country,
                              ),
                              CustomText(
                                text: controller.checkouts[index].phone,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Total Billed',
                                    color: primaryColor,
                                  ),
                                  CustomText(
                                    text:
                                        '\$${controller.checkouts[index].totalPrice}',
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
                itemCount: controller.checkouts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
