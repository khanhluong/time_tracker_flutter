import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/screens/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter/screens/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/screens/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class SignPage extends StatelessWidget {
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> signInAnonymoustly(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign In with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () => signInWithGoogle(context),
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign In with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () => signInWithFacebook(context),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: 'Sign In with Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: () => signInAnonymoustly(context),
          ),
        ],
      ),
    );
  }
}
