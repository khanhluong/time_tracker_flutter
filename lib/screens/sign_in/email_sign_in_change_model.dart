import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter/screens/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/screens/sign_in/validators.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.register
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get submitEnable {
    return emailValidator.isValid(email) && passwordValidator.isValid(password);
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? inValidPasswordText : null;
  }

  String get emailErrorText {
    bool showEmailError = submitted && !emailValidator.isValid(email);
    return showEmailError ? inValidEmailText : null;
  }

  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
