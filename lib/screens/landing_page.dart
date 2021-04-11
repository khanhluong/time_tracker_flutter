import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/screens/home/home_page.dart';
import 'package:time_tracker_flutter/screens/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
    // print('User id: ${user.uid}');
  }

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignPage(
        onSignIn: _updateUser,
        auth: widget.auth,
      );
    } else {
      return HomePage(
        auth: widget.auth,
        onSignOutCallBack: () => _updateUser(null),
      );
    }
  }
}
