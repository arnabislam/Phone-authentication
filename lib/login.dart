import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footballfrick/forgot_password.dart';
import 'package:footballfrick/main.dart';
import 'package:footballfrick/services/auth.dart';
import 'package:footballfrick/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email='',password='';

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "My home")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFedf0f8),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter E-mail';
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 18.0)),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFedf0f8),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    obscureText: true,   ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email= emailcontroller.text;
                        password=passwordController.text;
                      });
                    }
                    userLogin();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF273671),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ))),
                ),

                const SizedBox(
                  height: 30.0,
                ),

                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()));
                }, child: Text("Forgot password")),


                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Icon(Icons.gamepad,color: Colors.green,)
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
          // GestureDetector(
          //   onTap: (){
          //     //Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
          //   },
          //   child: Text("Forgot Password?",
          //       style: TextStyle(
          //           color: Color(0xFF8c8e98),
          //           fontSize: 18.0,
          //           fontWeight: FontWeight.w500)),
          // ),
          // SizedBox(
          //   height: 40.0,
          // ),
          // Text(
          //   "or LogIn with",
          //   style: TextStyle(
          //       color: Color(0xFF273671),
          //       fontSize: 22.0,
          //       fontWeight: FontWeight.w500),
          // ),
          // SizedBox(
          //   height: 30.0,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: (){
          //        // AuthMethods().signInWithGoogle(context);
          //       },
          //       child: Image.asset(
          //         "images/google.png",
          //         height: 45,
          //         width: 45,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 30.0,
          //     ),
          //     GestureDetector(
          //       onTap: (){
          //        // AuthMethods().signInWithApple();
          //       },
          //       child: Image.asset(
          //         "images/apple1.png",
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 40.0,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Don't have an account?",
          //         style: TextStyle(
          //             color: Color(0xFF8c8e98),
          //             fontSize: 18.0,
          //             fontWeight: FontWeight.w500)),
          //     SizedBox(
          //       width: 5.0,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => Signup()));
          //       },
          //       child: Text(
          //         "SignUp",
          //         style: TextStyle(
          //             color: Color(0xFF273671),
          //             fontSize: 20.0,
          //             fontWeight: FontWeight.w500),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
