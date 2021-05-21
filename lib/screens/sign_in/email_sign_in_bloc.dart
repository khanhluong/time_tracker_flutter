import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter/screens/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;

  StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted}) {
    // update model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    _modelController.add(_model);
  }
}
