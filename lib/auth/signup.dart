import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email TextField
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter email or username',
                  ),
                ),
                SizedBox(height: 16),

                // Password TextField
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () {
                    // Handle login
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Divider with text
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Social Media Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                      onPressed: () {
                        // Handle Twitter login
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
