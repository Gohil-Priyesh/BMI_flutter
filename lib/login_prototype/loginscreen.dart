
import 'package:bmi_flutter/Home/HomePage.dart';
import 'package:bmi_flutter/login_prototype/reg_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'SQLHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter Your credential to login',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 375,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purple.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        controller: _username,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length <= 1) {
                            return "Please enter a valid username";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(22),
                          label: const Text('Username'),
                          prefixIcon: const Icon(Icons.person, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 375,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purple.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        controller: _password,
                        validator: (pass) {
                          if (pass == null || pass.isEmpty || pass.length < 6) {
                            return "Please enter a valid password";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        maxLength: 6,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(22),
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 63,
                    width: 370,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.purple),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _authenticateUser();
                        }
                      },
                      child: const Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: 'Don’t have an account? ', style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authenticateUser() async {
    String username = _username.text;
    String password = _password.text;

    bool isAuthenticated = await SQLHelper.authenticate(username, password);

    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));
    }
  }
}
