import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart' as colors;

class ButtonEniac extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Function()? onPressed;
  final Color? colorBackground;
  final String? message;
  const ButtonEniac({
    Key? key,
    this.isLoading = false,
    required this.text,
    this.onPressed,
    this.colorBackground,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              onPressed == null
                  ? colors.customGrey
                  : (colorBackground ?? colors.customBlack),
            ),
            // 15 de borderRadius
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: funcIfDisabled(
            context,
            message,
            isLoading,
            onPressed,
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colors.customBackground),
                  )
                : Text(
                    text,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colors.customWhite,
                    ),
                  ),
          )),
    );
  }

  Function()? funcIfDisabled(
      context, String? message, bool isLoading, Function()? onPressed) {
    if (isLoading) {
      return null;
    }
    if (message != null) {
      return () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: message,
          title: 'Atenção',
        );
      };
    }
    return onPressed;
  }
}
