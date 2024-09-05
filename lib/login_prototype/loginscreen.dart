import 'package:bmi_flutter/Home/HomePage.dart';
import 'package:bmi_flutter/login_prototype/reg_screen.dart';
import 'package:flutter/material.dart';



import 'SQLHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, dynamic>>_authintcate = [];

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text('Welcome Back',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
              Text('Enter Your credential to login',
                style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 50,),
              SizedBox(
                width: 375,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purple.withOpacity(0.1)
                  ),
                  child: TextFormField(
                    controller: _username,
                    validator: (value){
                      if(value == null || value.length <= 1 || value.isEmpty){
                        return "pleas enter a valid user name";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(22),
                        label: Text('Username'),
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 375,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purple.withOpacity(0.1)
                  ),
                  child: TextFormField(
                    controller: _password,
                    validator: (pass){
                      if(pass == null || pass.isEmpty || pass.length < 6){
                        return "please enter a valid password ";
                      }
                      return null;

                    },
                    /// for auto validating the input when the user interact with the TextForField
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(22),
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.password, color: Colors.grey,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                        obscureText: true,
                        maxLength: 6,

                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 63,
                width: 370,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.purple)),
                    onPressed: () {
                      if(_formKey.currentState!.validate() == true){
                        _authenticateUser();
                      }
                    },
                    child: Text('Login', style: TextStyle(color: Colors.white),)),
              ),
              Flexible(child: SizedBox(height: 100,)),
              Flexible(child: Text('Forgot password?', style: TextStyle(
                  color: Colors.purple, fontWeight: FontWeight.w500),)),
              Flexible(child: SizedBox(height: 120,)),
              InkWell(onTap: () {
               // _authUser();
              },
                child: Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignupPage(),));
                    },
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Dont have an account?   ', style: TextStyle(
                              color: Colors.black)),
                          TextSpan(text: 'Sign Up', style: TextStyle(color: Colors
                              .purple, fontWeight: FontWeight.w500)),
                        ]
                    )),
                  ),
                ),
              ),
            ],
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
      // successful login
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!'))
      );
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // failed login
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password'))
      );
    }
  }
}
