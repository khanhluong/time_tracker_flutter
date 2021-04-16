import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/screens/sign_in/email_sign_in_form.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase authBase;

  const EmailSignInPage({@required this.authBase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(
            authBase: authBase,
          ),
        ),
      ),
    );
  }
}
