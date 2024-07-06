import 'package:flutter/material.dart';

class customFormField extends StatelessWidget {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3387845326.
  final String labeltext;
  final double height;
  final RegExp validationRegEx;
  final bool obscureText;

  final void Function(String?) onSaved;

  const customFormField(
      {super.key,
      required this.height,
      required this.labeltext,
      required this.validationRegEx,
      required this.onSaved,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) {
          if (value != null && validationRegEx.hasMatch(value)) {
            return null;
          }
          return "Enter a valid ${labeltext.toLowerCase()}";
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labeltext,
        ),
      ),
    );
  }
}
