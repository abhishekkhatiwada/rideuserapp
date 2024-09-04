import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parkwell/constant/constant.dart';
import 'package:parkwell/controller/profile_controller.dart';
import 'package:parkwell/themes/app_them_data.dart';
import 'package:parkwell/themes/common_ui.dart';
import 'package:parkwell/themes/custom_dialog_box.dart';
import 'package:parkwell/themes/filled_list_tile.dart';
import 'package:parkwell/themes/responsive.dart';
import 'package:parkwell/themes/round_button_fill.dart';
import 'package:parkwell/ui/auth_screen/login_screen.dart';
import 'package:parkwell/ui/chat/inbox_screen.dart';
import 'package:parkwell/ui/contact_us/contact_us_screen.dart';
import 'package:parkwell/ui/faq/faq_screen.dart';
import 'package:parkwell/ui/profile/edit_profile_screen.dart';
import 'package:parkwell/ui/refer_and_earn/refer_and_earn_screen.dart';
import 'package:parkwell/ui/setting_screen/setting_screen.dart';
import 'package:parkwell/ui/terms_and_condition/terms_and_condition_screen.dart';
import 'package:parkwell/ui/wallet/wallet_screen.dart';
import 'package:parkwell/utils/dark_theme_provider.dart';
import 'package:parkwell/utils/network_image_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: UiInterface().customAppBar(
              context,
              themeChange,
              isBack: false,
              'profile'.tr,
              actions: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(const InboxScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.chat_bubble_outline,
                        color: themeChange.getThem()
                            ? AppThemData.grey01
                            : AppThemData.grey08),
                  ),
                )
              ],
            ),
            body: controller.isLoading.value
                ? Constant.loader()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: NetworkImageWidget(
                                    imageUrl: controller
                                        .userModel.value.profilePic
                                        .toString(),
                                    height: Responsive.width(26, context),
                                    width: Responsive.width(26, context),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.userModel.value.fullName
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: AppThemData.medium,
                                          color: themeChange.getThem()
                                              ? AppThemData.grey01
                                              : AppThemData.grey10),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.userModel.value.email
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: AppThemData.medium,
                                          color: themeChange.getThem()
                                              ? AppThemData.grey06
                                              : AppThemData.grey06),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    RoundedButtonFill(
                                      title: "Edit Details".tr,
                                      textColor: AppThemData.white,
                                      width: 40,
                                      height: 05.55,
                                      isRight: false,
                                      icon: const Icon(Icons.edit,
                                          color: AppThemData.white),
                                      color: AppThemData.primary06,
                                      onPress: () {
                                        Get.to(const EditProfileScreen());
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          FilledListTile(
                            title: "Wallet".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_wallet.svg",
                            onPressed: () {
                              Get.to(() => const WalletScreen());
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Wallet".tr,
                          //   svgImage: "assets/icon/ic_wallet.svg",
                          //   onTap: () {
                          //     Get.to(() => const WalletScreen());
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          Divider(
                              color: themeChange.getThem()
                                  ? AppThemData.white
                                  : AppThemData.grey11,
                              thickness: 1),
                          FilledListTile(
                            title: "Settings".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_setting.svg",
                            onPressed: () {
                              Get.to(() => const SettingScreen());
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Settings".tr,
                          //   svgImage: "assets/icon/ic_setting.svg",
                          //   onTap: () {
                          //     Get.to(() => const SettingScreen());
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          FilledListTile(
                            title: "Refer and Earn".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_refer_and_eran.svg",
                            onPressed: () {
                              Get.to(() => const ReferAndEarnScreen());
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Refer and Earn".tr,
                          //   svgImage: "assets/icon/ic_refer_and_eran.svg",
                          //   onTap: () {
                          //     Get.to(() => const ReferAndEarnScreen());
                          //   },
                          //   themeChange: themeChange,s
                          // ),
                          FilledListTile(
                            title: "Privacy Policy".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_privacy_policy.svg",
                            onPressed: () {
                              Get.to(const TermsAndConditionScreen(
                                type: "privacy",
                              ));
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Privacy Policy".tr,
                          //   svgImage: "assets/icon/ic_privacy_policy.svg",
                          //   onTap: () {
                          //     Get.to(const TermsAndConditionScreen(
                          //       type: "privacy",
                          //     ));
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          FilledListTile(
                            title: "Terms & Conditions".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_terms_condition.svg",
                            onPressed: () {
                              Get.to(const TermsAndConditionScreen(
                                type: "terms",
                              ));
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Terms & Conditions".tr,
                          //   svgImage: "assets/icon/ic_terms_condition.svg",
                          //   onTap: () {
                          //     Get.to(const TermsAndConditionScreen(
                          //       type: "terms",
                          //     ));
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          FilledListTile(
                            title: "Support".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_support.svg",
                            onPressed: () async {
                              final Uri url =
                                  Uri.parse(Constant.supportURL.toString());
                              if (!await launchUrl(url)) {
                                throw Exception(
                                    'Could not launch ${Constant.supportURL.toString()}'
                                        .tr);
                              }
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Support".tr,
                          //   svgImage: "assets/icon/ic_support.svg",
                          //   onTap: () async {
                          //     final Uri url =
                          //         Uri.parse(Constant.supportURL.toString());
                          //     if (!await launchUrl(url)) {
                          //       throw Exception(
                          //           'Could not launch ${Constant.supportURL.toString()}'
                          //               .tr);
                          //     }
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          FilledListTile(
                            title: "Contact us".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_call_support.svg",
                            onPressed: () {
                              Get.to(
                                () => const ContactUsScreen(),
                              );
                            },
                          ),
                          // menuItemWidget(
                          //   title: "Contact us".tr,
                          //   svgImage: "assets/icon/ic_call_support.svg",
                          //   onTap: () {
                          //     Get.to(
                          //       () => const ContactUsScreen(),
                          //     );
                          //   },
                          //   themeChange: themeChange,
                          // ),

                          FilledListTile(
                            title: "FAQ’s".tr,
                            description: '',
                            imageUrl: "assets/icon/ic_faq.svg",
                            onPressed: () {
                              Get.to(() => const FaqScreen());
                            },
                          ),
                          // menuItemWidget(
                          //   title: "FAQ’s".tr,
                          //   svgImage: "assets/icon/ic_faq.svg",
                          //   onTap: () {
                          //     Get.to(() => const FaqScreen());
                          //   },
                          //   themeChange: themeChange,
                          // ),
                          Divider(
                              color: themeChange.getThem()
                                  ? AppThemData.white
                                  : AppThemData.grey11,
                              thickness: 1),
                          RoundedButtonFill(
                            title: "Log Out".tr,
                            color: AppThemData.grey10,
                            textColor: AppThemData.grey01,
                            // svgImage: "assets/icon/ic_logout.svg",
                            onPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: "Signing out for now?".tr,
                                      descriptions:
                                          "Ensure your account's security with a quick log out. Your parking solutions will be here when you return!"
                                              .tr,
                                      positiveString: "Log out".tr,
                                      negativeString: "Cancel".tr,
                                      positiveClick: () async {
                                        await FirebaseAuth.instance.signOut();
                                        Get.offAll(const LoginScreen());
                                      },
                                      negativeClick: () {
                                        Get.back();
                                      },
                                      img: SvgPicture.asset(
                                          'assets/images/ic_logout_image.svg'),
                                    );
                                  });
                              // showLogoutAccountDialog(context, themeChange);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  Widget menuItemWidget({
    required String svgImage,
    required String title,
    required VoidCallback onTap,
    required themeChange,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      horizontalTitleGap: 6,
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      leading: SvgPicture.asset(
        svgImage,
        color: title == "Log Out"
            ? AppThemData.error08
            : themeChange.getThem()
                ? AppThemData.grey01
                : AppThemData.grey09,
        height: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            fontFamily: AppThemData.medium,
            color: title == "Log Out"
                ? AppThemData.error08
                : themeChange.getThem()
                    ? AppThemData.grey01
                    : AppThemData.grey09),
      ),
    );
  }
}
