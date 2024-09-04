import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkwell/themes/app_them_data.dart';
import 'package:parkwell/utils/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class UiInterface {
  AppBar customAppBar(
    BuildContext context,
    themeChange,
    String title, {
    bool isBack = true,
    Color? backgroundColor,
    Color iconColor = AppThemData.grey02,
    Color textColor = AppThemData.grey02,
    List<Widget>? actions,
    Function()? onBackTap,
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: themeChange.getThem() ? AppThemData.grey02 : textColor,
            fontFamily: AppThemData.semiBold,
            fontSize: 18),
      ),
      backgroundColor: themeChange.getThem()
          ? backgroundColor ?? AppThemData.grey10
          : backgroundColor ?? AppThemData.grey10,
      automaticallyImplyLeading: isBack,
      elevation: 0,
      centerTitle: false,
      titleSpacing: isBack == true ? 0 : 16,
      leading: isBack
          ? InkWell(
              onTap: onBackTap ??
                  () {
                    Get.back();
                  },
              child: Icon(Icons.arrow_back_ios,
                  color:
                      themeChange.getThem() ? AppThemData.grey02 : iconColor),
            )
          : null,
      actions: actions,
    );
  }
}
