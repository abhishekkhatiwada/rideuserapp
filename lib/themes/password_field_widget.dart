import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkwell/themes/app_them_data.dart';
import 'package:parkwell/utils/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final Function() onPress;
  final Widget? prefix;

  final bool? enable;
  final int? maxLine;
  final TextInputType? textInputType;

  final List<TextInputFormatter>? inputFormatters;

  const PasswordFieldWidget(
      {super.key,
      this.textInputType,
      this.enable,
      this.prefix,
      this.title,
      required this.hintText,
      required this.controller,
      required this.onPress,
      this.maxLine,
      this.inputFormatters});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title ?? '',
                    style: const TextStyle(
                        fontFamily: AppThemData.medium,
                        fontSize: 14,
                        color: AppThemData.grey11)),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.textInputType ?? TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: widget.controller,
            textAlign: TextAlign.start,
            obscureText: obscureText,
            maxLines: widget.maxLine ?? 1,
            textInputAction: TextInputAction.done,
            inputFormatters: widget.inputFormatters,
            style: TextStyle(
                fontSize: 14,
                color: themeChange.getThem()
                    ? AppThemData.grey02
                    : AppThemData.grey08,
                fontWeight: FontWeight.w500,
                fontFamily: AppThemData.medium),
            decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.red),
                isDense: true,
                filled: true,
                enabled: widget.enable ?? true,
                fillColor: themeChange.getThem()
                    ? AppThemData.grey10
                    : AppThemData.white,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 16, horizontal: widget.prefix != null ? 0 : 10),
                prefixIcon: widget.prefix,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(obscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded),
                ),
                suffixIconColor: themeChange.getThem()
                    ? AppThemData.white
                    : AppThemData.grey10,
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeChange.getThem()
                          ? AppThemData.grey09
                          : AppThemData.grey04,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeChange.getThem()
                          ? AppThemData.grey09
                          : AppThemData.grey04,
                      width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeChange.getThem()
                          ? AppThemData.grey09
                          : AppThemData.grey04,
                      width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeChange.getThem()
                          ? AppThemData.grey09
                          : AppThemData.grey04,
                      width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  borderSide: BorderSide(
                      color: themeChange.getThem()
                          ? AppThemData.grey09
                          : AppThemData.grey04,
                      width: 1),
                ),
                hintText: widget.hintText.tr,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: themeChange.getThem()
                        ? AppThemData.grey06
                        : AppThemData.grey06,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppThemData.medium)),
          ),
        ],
      ),
    );
  }
}
