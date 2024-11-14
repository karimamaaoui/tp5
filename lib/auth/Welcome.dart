import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth User

class WelcomeUserWidget extends StatelessWidget {
  final GoogleSignIn _googleSignIn;
  final User _user;

  WelcomeUserWidget(this._user, this._googleSignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.teal[600],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _googleSignIn.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
          child: Container(
            color: Colors.teal, // Example background color for styling
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _user.email ?? 'No Email', // Null check in case email is null
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
            ),
          ),

      ),
    );
  }
}
