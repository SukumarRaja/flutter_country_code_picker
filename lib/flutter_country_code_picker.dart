library flutter_country_code_picker;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'intl_phone_code.dart';
import 'model/phone.dart';

class CountryCodeTextFormField extends StatefulWidget {
  final String? initialCountryCode;
  final String? hintText;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? buttonTextColor;
  final Color? buttonHintTextColor;
  final TextStyle? hintStyle;
  final String? buttonText;
  final int? maxLength;
  final FocusNode nextFocus;
  final FocusNode focusNode;
  final Function(PhoneNumber? phone)? onSaved;

  const CountryCodeTextFormField(
      {super.key,
      this.height,
      this.width,
      this.borderColor,
      this.buttonHintTextColor,
      this.hintStyle,
      this.buttonTextColor,
      this.onSaved,
      this.hintText,
      this.controller,
      this.initialCountryCode,
      this.buttonText,
      this.maxLength,
      required this.nextFocus,
      required this.focusNode});

  @override
  _CountryCodeTextFormFieldState createState() =>
      _CountryCodeTextFormFieldState();
}

class _CountryCodeTextFormFieldState extends State<CountryCodeTextFormField> {
  BoxDecoration boxDecoration(
      {double radius = 5,
      Color bgColor = Colors.white,
      var showShadow = false}) {
    return BoxDecoration(
        color: bgColor,
        boxShadow: showShadow
            ? [
                const BoxShadow(
                    color: AppColors.primary, blurRadius: 10, spreadRadius: 2)
              ]
            : [const BoxShadow(color: Colors.transparent)],
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(bottom: 7, top: 5),
          height: widget.height ?? 50,
          width: widget.width ?? MediaQuery.of(this.context).size.width,
          decoration: boxDecoration(),
          child: IntlPhoneField(
            nextFocus: widget.nextFocus,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            searchText: "Search by Country / Region Name",
            dropDownArrowColor: widget.buttonHintTextColor ?? Colors.grey[300],
            textAlign: TextAlign.left,
            initialCountryCode: widget.initialCountryCode,
            controller: widget.controller,
            style: TextStyle(
                height: 1.35,
                letterSpacing: 1,
                fontSize: 16.0,
                color: widget.buttonTextColor ?? Colors.black87,
                fontWeight: FontWeight.bold),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(3, 15, 8, 0),
                hintText: widget.hintText ??
                    // getTranslated(this.context, 'enter_mobilenumber'),
                    "phone",
                hintStyle: widget.hintStyle ??
                    TextStyle(
                        letterSpacing: 1,
                        height: 0.0,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).hintColor),
                fillColor: Colors.white,
                filled: true,
                counterText: "",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                )),
            onChanged: (phone) {
              widget.onSaved!(phone);
            },
            validator: (v) {
              return null;
            },
            // onSaved: widget.onSaved!
          ),
        ),
        Positioned(
            left: 100,
            child: Container(
              width: 2,
              height: widget.height ?? 48,
              color: Colors.grey.withOpacity(.3),
            ))
      ],
    );
  }
}
