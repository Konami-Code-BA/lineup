import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseAuth.instance.sendPasswordResetEmail(
                    email: _emailController.text.trim(),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
