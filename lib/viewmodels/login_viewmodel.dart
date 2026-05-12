import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {

  bool login(
    GlobalKey<FormState> formKey,
  ) {

    if (formKey.currentState!.validate()) {
      return true;
    }

    return false;
  }
}