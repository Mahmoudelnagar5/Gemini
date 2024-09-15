import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.isEnabled,
      this.controller,
      this.onSaved,
      this.validator});
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool? isEnabled;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onSaved,
      controller: controller,
      enabled: isEnabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: suffixIcon,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 49, 54, 67),
        hintText: hintText,
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
        border: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(25));
}
