import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkwell/themes/app_them_data.dart';
import 'package:parkwell/utils/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class FilledListTile extends StatelessWidget {
  final String title;
  final String description;
  final void Function()? onPressed;
  final IconData? icon;
  final EdgeInsets? margin;
  final String? imageUrl;
  final Widget? midWidget;
  final Widget? trailing;
  final Color? subtitleTextColor;
  final Color? iconColor;
  final double horizontalMargin;
  final double bottomMargin;

  const FilledListTile({
    Key? key,
    required this.title,
    required this.description,
    this.onPressed,
    this.icon,
    this.margin,
    this.imageUrl,
    this.midWidget,
    this.trailing,
    this.subtitleTextColor,
    this.iconColor,
    this.horizontalMargin = 0,
    this.bottomMargin = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      margin: margin ??
          EdgeInsets.only(
            bottom: bottomMargin,
            left: horizontalMargin,
            right: horizontalMargin,
          ),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: themeChange.getThem() ? AppThemData.grey09 : AppThemData.white,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: themeChange.getThem()
                      ? AppThemData.grey01
                      : AppThemData.grey09,
                )),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            child: Row(
              children: [
                if (icon != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.only(right: 12),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppThemData.primary06,
                      size: 20,
                    ),
                  ),
                if (imageUrl != null)
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(100),
                    // ),
                    margin: const EdgeInsets.only(right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: SvgPicture.asset(
                        imageUrl!,
                        // fit: BoxFit.cover,
                        height: 20,
                        width: 20,
                        color: themeChange.getThem()
                            ? AppThemData.grey01
                            : AppThemData.grey09,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppThemData.medium,
                              color: themeChange.getThem()
                                  ? AppThemData.grey01
                                  : AppThemData.grey09),
                        ),
                      if (title.isNotEmpty) const SizedBox(height: 4),
                      if (description.isNotEmpty)
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: AppThemData.medium,
                              color: themeChange.getThem()
                                  ? AppThemData.grey01
                                  : AppThemData.grey09),
                        ),
                    ],
                  ),
                ),
                if (midWidget != null) midWidget!,
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios,
                      color: themeChange.getThem()
                          ? AppThemData.grey01
                          : AppThemData.grey09,
                      size: 20,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
