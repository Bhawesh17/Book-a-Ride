import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({ this.title, this.color, this.backgroundcolor, required this.onPressed, this.isloading = false});

  final Color? color;
  final Color? backgroundcolor;
  final String? title;
  final bool  isloading;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0 , horizontal: 5.0),
      child: Material(
        elevation: 5.0,
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(

          onPressed: onPressed,
         // minWidth: 100.0,
          height: 30.0,
          child: Container(
            alignment: Alignment.center,
            child: isloading ?
            CircularProgressIndicator(strokeWidth: 4, color: Colors.white,)
            : Text(

              title!,

              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
