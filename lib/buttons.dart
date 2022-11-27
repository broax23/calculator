import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final buttonColor;
  final textColor;
  final String buttonText;
  final buttonTapped;

  const MyButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.buttonText,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
