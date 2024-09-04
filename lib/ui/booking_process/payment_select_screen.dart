import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkwell/constant/constant.dart';
import 'package:parkwell/constant/show_toast_dialog.dart';
import 'package:parkwell/controller/paymnet_select_controller.dart';
import 'package:parkwell/model/wallet_transaction_model.dart';
import 'package:parkwell/payment/createRazorPayOrderModel.dart';
import 'package:parkwell/payment/rozorpayConroller.dart';
import 'package:parkwell/themes/app_them_data.dart';
import 'package:parkwell/themes/common_ui.dart';
import 'package:parkwell/themes/round_button_fill.dart';
import 'package:parkwell/utils/dark_theme_provider.dart';
import 'package:parkwell/utils/fire_store_utils.dart';
import 'package:provider/provider.dart';

class PaymentSelectScreen extends StatelessWidget {
  const PaymentSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<PaymentSelectController>(
        init: PaymentSelectController(),
        builder: (controller) {
          return Scaffold(
            appBar: UiInterface().customAppBar(context, themeChange, "Select Payment Method".tr),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isLoading.value
                        ? Constant.loader()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: controller.paymentModel.value.paywell != null && controller.paymentModel.value.paywell!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.paywell!.name.toString(), themeChange, "assets/images/paywell.webp"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.wallet != null && controller.paymentModel.value.wallet!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.wallet!.name.toString(), themeChange, "assets/images/wallet.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.strip != null && controller.paymentModel.value.strip!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.strip!.name.toString(), themeChange, "assets/images/strip.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.paypal != null && controller.paymentModel.value.paypal!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.paypal!.name.toString(), themeChange, "assets/images/paypal.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.payStack != null && controller.paymentModel.value.payStack!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.payStack!.name.toString(), themeChange, "assets/images/paystack.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.mercadoPago != null && controller.paymentModel.value.mercadoPago!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.mercadoPago!.name.toString(), themeChange, "assets/images/mercadopogo.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.flutterWave != null && controller.paymentModel.value.flutterWave!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.flutterWave!.name.toString(), themeChange, "assets/images/flutterwave.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.payfast != null && controller.paymentModel.value.payfast!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.payfast!.name.toString(), themeChange, "assets/images/payfast.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.paytm != null && controller.paymentModel.value.paytm!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.paytm!.name.toString(), themeChange, "assets/images/paytm.png"),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value.razorpay != null && controller.paymentModel.value.razorpay!.enable == true,
                                  child: cardDecoration(controller, controller.paymentModel.value.razorpay!.name.toString(), themeChange, "assets/images/rezorpay.png"),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: themeChange.getThem() ? AppThemData.grey10 : AppThemData.grey11,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RoundedButtonFill(
                  title: "Pay".tr,
                  color: AppThemData.primary06,
                  textColor: AppThemData.white,
                  onPress: () async {
                    if (controller.selectedPaymentMethod.value == controller.paymentModel.value.strip!.name) {
                      controller.stripeMakePayment(amount: controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.paywell!.name) {
                      controller.processPaywellPayment(amount: controller.calculateAmount().toStringAsFixed(0),title: 'Payment For Booking',description: 'Payment For Booking');
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.paypal!.name) {
                      controller.paypalPaymentSheet(controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.payStack!.name) {
                      controller.payStackPayment(controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.mercadoPago!.name) {
                      controller.mercadoPagoMakePayment(context: context, amount: controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.flutterWave!.name) {
                      controller.flutterWaveInitiatePayment(context: context, amount: controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.payfast!.name) {
                      controller.payFastPayment(context: context, amount: controller.calculateAmount().toStringAsFixed(Constant.currencyModel!.decimalDigits!));
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.paytm!.name) {
                      controller.getPaytmCheckSum(context, amount: controller.calculateAmount());
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.razorpay!.name) {
                      RazorPayController().createOrderRazorPay(amount: controller.calculateAmount().toInt(), razorpayModel: controller.paymentModel.value.razorpay).then((value) {
                        if (value == null) {
                          Get.back();
                          ShowToastDialog.showToast("Something went wrong, please contact admin.".tr);
                        } else {
                          CreateRazorPayOrderModel result = value;
                          controller.openCheckout(amount: controller.calculateAmount().toInt(), orderId: result.id);
                        }
                      });
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.wallet!.name) {
                      if (double.parse(controller.userModel.value.walletAmount.toString()) >= controller.calculateAmount()) {
                        WalletTransactionModel transactionModel = WalletTransactionModel(
                            id: Constant.getUuid(),
                            amount: "-${controller.calculateAmount().toString()}",
                            createdDate: Timestamp.now(),
                            paymentType: controller.selectedPaymentMethod.value,
                            transactionId: controller.orderModel.value.id,
                            note: "Parking amount debit".tr,
                            userId: FireStoreUtils.getCurrentUid(),
                            isCredit: false);

                        await FireStoreUtils.setWalletTransaction(transactionModel).then((value) async {
                          if (value == true) {
                            await FireStoreUtils.updateUserWallet(amount: "-${controller.calculateAmount().toString()}").then((value) {
                              controller.completeOrder();
                            });
                          }
                        });
                      } else {
                        ShowToastDialog.showToast("Wallet Amount Insufficient".tr);
                      }
                    } else if (controller.selectedPaymentMethod.value == controller.paymentModel.value.cash!.name) {
                      controller.completeCashOrder();
                    }
                  },
                ),
              ),
            ),
          );
        });
  }

  cardDecoration(PaymentSelectController controller, String value, themeChange, String image) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            onTap: () {
              controller.selectedPaymentMethod.value = value;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(color: themeChange.getThem() ? AppThemData.grey10 : AppThemData.grey03, borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      image,
                      width: 80,
                      height: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: themeChange.getThem() ? AppThemData.grey01 : AppThemData.grey08),
                    ),
                  ),
                  if (value.toLowerCase() == 'wallet'.toLowerCase())
                    Text(Constant.amountShow(amount: controller.userModel.value.walletAmount),
                        style: TextStyle(fontSize: 16, fontFamily: AppThemData.semiBold, color: themeChange.getThem() ? AppThemData.grey01 : AppThemData.grey10)),
                  Radio(
                    value: value.toString(),
                    groupValue: controller.selectedPaymentMethod.value,
                    activeColor: themeChange.getThem() ? AppThemData.primary08 : AppThemData.primary08,
                    onChanged: (value) {
                      controller.selectedPaymentMethod.value = value.toString();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
