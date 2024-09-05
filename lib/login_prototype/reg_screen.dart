import 'package:bmi_flutter/login_prototype/loginscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'SQLHelper.dart';

class SignupPage extends StatefulWidget {


  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<Map<String,dynamic>> _authintcate=[];

  final TextEditingController _username = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _ConfirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth();
  }

  void _auth()async{
    final data = await SQLHelper.getItems();
    setState(() {
      _authintcate =data;
      print("...number of user ${_authintcate.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),

                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                            validator: (value) {
                              if(value == null || value.length <= 1 || value.isEmpty){
                                return "Username should be more then one character";
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "enter Email";
                          }
                          /// i don't know how to use this package
                          /* if(EmailValidator.validate(value.toString())){
                             return "enter a valid email";
                           }*/
                           if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                               .hasMatch(value)){
                           }else{
                             return "enter a valid email Id";
                           }
                          return null;
                          },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: Icon(CupertinoIcons.eye,color: Colors.purple,)
                        ),
                        obscureText: true,
                        validator: (value) {
                          if( value == null || value.isEmpty || value.length <= 5){
                            return "enter a valid value";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 6,
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _ConfirmPassword,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                                showPassword ?
                                    Icons.remove_red_eye : Icons.remove_red_eye_outlined
                            ),
                            onPressed: (){
                              setState(() {
                                showPassword = ! showPassword;
                              });
                            },
                          )
                        ),
                        obscureText: true,
                        validator: (value){
                          if( value == null || value.isEmpty || value.length < 6 ){
                            return "enter a valid value";
                          }
                          /// make sure to use .text to access the text from the controller or else it wonk work
                          if(value != _password.text){
                            return "enter the same password as above";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 6,
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate() == true){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfull")));
                          _addItem();
                        }
                        },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                    )
                ),

                const Center(child: Text("Or")),

                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.purple,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   height: 30.0,
                        //   width: 30.0,
                        //   decoration: const BoxDecoration(
                        //    /* image: DecorationImage(
                        //         image:   AssetImage('assets/images/login_signup/google.png'),*/
                        //        // fit: BoxFit.cover),
                        //     shape: BoxShape.circle,
                        //   ),
                        // ),

                        // SizedBox(width: 18),

                        Text("Sign In with Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.purple),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _username.text, _password.text,_email.text);
    _auth();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-in Sucessfull'))
    );
  }
}