import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/screens/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormBLocBased extends StatefulWidget {
  EmailSignInFormBLocBased({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBLocBased(
          bloc: bloc,
        ),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBLocBasedState createState() =>
      _EmailSignInFormBLocBasedState();
}

class _EmailSignInFormBLocBasedState extends State<EmailSignInFormBLocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    print('Dispose called');
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      if (Platform.isIOS) {
        print('Show CupertinoAlertDialog');
      } else {
        showExceptionAlertDialog(
          context,
          title: 'Sign In Fail',
          exception: e,
        );
      }
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType() {
    widget.bloc.toogleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildchildren([EmailSignInModel model]) {
    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        onPressed: model.submitEnable ? _submit : null,
        text: model.primaryButtonText,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toogleFormType : null,
        child: Text(model.secondaryButtonText),
      )
    ];
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: widget.bloc.updateEmail,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  TextField _buildPasswordTextField([EmailSignInModel model]) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: _submit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildchildren(model),
            ),
          );
        });
  }
}
