import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tp5/auth/Welcome.dart';
import 'package:tp5/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  bool isLoginSuccessful = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isUserSignedIn = false;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        setState(() {
          isLoginTrue = false;
          isLoginSuccessful = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Login successful!",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoginTrue = true;
          isLoginSuccessful = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: e.code == 'weak-password'
                ? Colors.orangeAccent
                : Colors.red,
            content: Text(
              e.code == 'weak-password'
                  ? "Password provided is too weak"
                  : "An error occurred. Please try again.",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please fill all fields",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  Future<void> onGoogleSignIn(BuildContext context) async {
    User? user = await _handleSignIn();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeUserWidget(user, _googleSignIn),
        ),
      );
    }
  }

  Future<User?> _handleSignIn() async {
    User? user;
    bool isSignedIn = await _googleSignIn.isSignedIn();

    if (isSignedIn) {
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        user = (await _auth.signInWithCredential(credential)).user;
      }
    }

    setState(() {
      isUserSignedIn = user != null;
    });

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: Colors.teal[600],
      ),
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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(context),
                _inputField(context),
                _signup(context),
                if (isLoginTrue)
                  const Text(
                    "Login failed. Please check your credentials.",
                    style: TextStyle(color: Colors.red),
                  ),
                if (isLoginSuccessful)
                  const Text(
                    "Welcome! You have successfully logged in.",
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        // Handle Twitter login
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      onPressed: () => onGoogleSignIn(context),
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

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please sign in to your account"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
            ),
          ),
          obscureText: !isVisible,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: login,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.teal[600],
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.teal)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
