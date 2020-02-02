import 'package:flutter/material.dart';

Widget affix(String text, bool isPrefix,
    {Color backgroundColor, Color foregroundColor}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.grey[400],
      borderRadius: isPrefix
          ? BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            )
          : BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
      child: Text(
        text,
        style: TextStyle(
          color: foregroundColor ?? Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}

class TextInput extends StatelessWidget {
  const TextInput(
    this.placeholder, {
    this.onTextChanged,
    this.isDark = false,
    this.prefixText,
    this.suffixText,
    this.keyboardType = TextInputType.text,
  });
  final Function onTextChanged;
  final String placeholder;
  final bool isDark;
  final String prefixText;
  final String suffixText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        children: <Widget>[
          if (prefixText != null) affix(prefixText, true),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
              child: TextField(
                keyboardType: keyboardType,
                style: TextStyle(
                  fontSize: 18.0,
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[600] : Colors.grey[700],
                  ),
                ),
                onChanged: onTextChanged,
              ),
            ),
          ),
          if (suffixText != null) affix(suffixText, false),
        ],
      ),
    );
  }
}
