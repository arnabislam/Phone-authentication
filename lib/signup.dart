

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footballfrick/main.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  String email='',password='',name='';

    TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final _formKey=GlobalKey<FormState>();



  registration() async {
    if (password != null&& nameController.text!=""&& emailController.text!="") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage(title: "My home")));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,

      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Please enter the name";
                }
                return null;
              },
              controller: emailController,

              decoration: InputDecoration(
                  hintText: 'Enter email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
            ),

            SizedBox(height: 15,),
            TextFormField(
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Please enter the EMAIL";
                }
                return null;
              },
              controller: nameController,

              decoration: InputDecoration(
                  hintText: 'Enter Name',
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
            ),

            SizedBox(height: 15,),
            TextFormField(
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Please enter the Password";
                }
                return null;
              },
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
            ),

            SizedBox(height: 25,),

      GestureDetector(
        onTap: (){
          if(_formKey.currentState!.validate()){
            setState(() {
              email=emailController.text;
              name= nameController.text;
              password=passwordController.text;
            });
          }
          registration();
        },
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Color(0xFF273671),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500),
                    ))),

            SizedBox(height: 25,),

            TextButton(onPressed: (){

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login()));
            }, child: Text("Login"))
          ],
        ),
      )],
        ),
      ),
    );
  }
}
