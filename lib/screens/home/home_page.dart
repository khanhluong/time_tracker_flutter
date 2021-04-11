import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {Key key, @required this.onSignOutCallBack, @required this.auth})
      : super(key: key);

  final AuthBase auth;

  final VoidCallback onSignOutCallBack;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOutCallBack();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            onPressed: _signOut,
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
