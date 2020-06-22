import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key key,
    @required TextEditingController itemController,
    this.hintText,
    this.validateMessage, this.keyboardType,
  })  : _controller = itemController,
        super(key: key);

  final TextEditingController _controller;
  final String hintText;
  final String validateMessage;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(Icons.clear),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }
}