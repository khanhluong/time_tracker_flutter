import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/screens/sign_in/validators.dart';
import 'package:time_tracker_flutter/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.authBase});
  final AuthBase authBase;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _emailController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.authBase.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.authBase.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toogleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildchildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.register
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        text: primaryText,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        onPressed: _toogleFormType,
        child: Text(secondaryText),
      )
    ];
  }

  TextField _buildEmailTextField() {
    bool emailValid = widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: emailValid ? null : widget.inValidEmailText,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) => _updateState(),
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildPasswordTextField() {
    bool emailPassword = widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: emailPassword ? null : widget.inValidEmailText,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildchildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
