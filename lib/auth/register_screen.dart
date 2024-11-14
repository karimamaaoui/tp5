import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isVisible = false;
  bool isLoginTrue = false;
  bool isLoginSuccessful = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _registerUser() async {


    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Show a success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Sign Up Successful"),
          content: Text("Your account has been created successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Navigate back to the login screen
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (error) {
      print(error);
      setState(() {
        _errorMessage = error.toString();
      });


      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Sign Up Failed"),
          content: Text("Error: $_errorMessage"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.teal[600],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _signup(context),
            if (isLoginTrue)
              const Text(
                "Register failed. Please check your credentials.",
                style: TextStyle(color: Colors.red),
              ),
            if (isLoginSuccessful)
              const Text(
                "Welcome! You have successfully logged in.",
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Register",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please sign up to your account"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
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
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: !isVisible,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed:_registerUser ,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.teal[600],
          ),
          child: const Text(
            "Register",
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
        const Text("Already have an account? ",
            style: TextStyle(color: Colors.teal)),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const RegisterScreen())); // Navigate to Sign Up page
          },
          child: const Text(
            "Sign in",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
