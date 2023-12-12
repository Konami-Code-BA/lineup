import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lineup/home.dart';
import 'package:lineup/utils/services/google_login.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.width * 0.05),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await GoogleLogin.loginWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LineupHomePage()),
                  );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage("assets/google_logo.png"),
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
