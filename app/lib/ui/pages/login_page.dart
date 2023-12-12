import 'package:flutter/material.dart';
import 'package:lineup/home.dart';
import 'package:lineup/ui/components/auth/google_sign_in_button.dart';
import 'package:lineup/utils/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenSize.width * 0.05,
            right: screenSize.width * 0.05,
            bottom: screenSize.width * 0.05,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          'assets/firebase_logo.png',
                          height: screenSize.height * 0.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Lineup',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          'Error initializing app. Ensure you\'re connected to the internet and try again');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Column(
                        children: [
                          const GoogleSignInButton(),
                          OutlinedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LineupHomePage()),
                                      (route) => false),
                              child: Text('Temporary debug button'))
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
