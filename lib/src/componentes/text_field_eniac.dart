import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart' as colors;

class TextFieldEniac extends StatelessWidget {
  final TextEditingController? controller;
  final bool isError;
  final String hintText;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool disableLine;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxCaracteres;
  final bool autoFocus;
  final Function(String)? onChanged;
  final Function(String?)? onSubmitted;
  final bool isDense;
  const TextFieldEniac({
    Key? key,
    this.controller,
    required this.isError,
    required this.hintText,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.suffixIcon,
    this.preffixIcon,
    this.disableLine = false,
    this.keyboardType,
    this.maxCaracteres,
    this.onChanged,
    this.onSubmitted,
    this.isDense = false,
    this.autoFocus = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      controller: controller,
      textInputAction: textInputAction,
      inputFormatters: [
        if (maxCaracteres != null)
          LengthLimitingTextInputFormatter(maxCaracteres),
      ],
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.customBlack,
      ),
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: _decorationTextField(
        hintText: hintText,
        suffixIcon: suffixIcon,
        isError: isError,
        preffixIcon: preffixIcon,
        disableLine: disableLine,
        isDense: isDense,
      ),
    );
  }
}

InputDecoration _decorationTextField({
  required String hintText,
  Widget? suffixIcon,
  bool isError = false,
  Widget? preffixIcon,
  bool disableLine = false,
  bool isDense = false,
}) {
  return InputDecoration(
    isDense: isDense,
    hintText: hintText,
    suffixIcon: suffixIcon,
    labelStyle: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: colors.customWhite,
    ),
    border: _borderTextField(isError, disableLine),
    enabledBorder: _borderTextField(isError, disableLine),
    focusedBorder: _borderTextField(isError, disableLine),
    errorBorder: _borderTextField(isError, disableLine),
    focusedErrorBorder: _borderTextField(isError, disableLine),
    disabledBorder: _borderTextField(isError, disableLine),
    prefixIcon: preffixIcon,
  );
}

InputBorder _borderTextField(
  bool isError,
  bool disableLine,
) {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(
      color: colors.customWhite,
      width: 1,
    ),
  );
}
