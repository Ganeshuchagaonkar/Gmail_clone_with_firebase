// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/methods.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class _SignupPageState extends State<SignupPage> {
   
 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  

  bool isloading=false;

 

 

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  Widget _submitButton() {
    String userName;
    String email;
    String password;

    return GestureDetector(
      onTap: () => {
       
      

  if(formKey.currentState.validate()){
    
    
    print("validate"),
      
    userName=_usernameController.text,
    email=_emailController.text,
    password=_passwordController.text,
    createAccount(userName, email, password).then((user) {
  

      if(user != null){
        
       CollectionReference users =FirebaseFirestore.instance.collection('user');
       FirebaseAuth _auth =FirebaseAuth.instance;
       String uid=_auth.currentUser.uid.toString();
       users.add({"name":userName,"password":password,"email":email,"uid":uid});
        setState(() {
                   isloading=false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Register Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
         Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));


      }
    })
  }
       
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.redAccent
           
            ),
        child: Text(
          'Sign up',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: 'S',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 60)),
        TextSpan(
            text: 'ign', style: TextStyle(color: Colors.black, fontSize: 40)),
        TextSpan(
          text: 'u',
          style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        TextSpan(
          text: 'p',
          style: TextStyle(color: Colors.redAccent, fontSize: 30),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.redAccent, fontSize: 50),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.redAccent, fontSize: 30),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.redAccent, fontSize: 20),
        ),
      ]),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         key: _scaffoldKey,
        body: Container(
      padding: EdgeInsets.only(top: 100, right: 30.0, left: 30.0, bottom: 60.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _title(),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                
                controller: _usernameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Username",
                    labelText: "Name"),
              ),

              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: validateEmail,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    border: InputBorder.none,
                    hintText: "email address",
                    labelText: "Email"),
              ),
              
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "This filed is required";
                  }
                  if (value.length < 4) {
                    return "Create a strong a password";
                  }
                  return null;
                },
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  border: InputBorder.none,
                  hintText: "password",
                  labelText: "password",
                ),
              ),
             
              
              SizedBox(
                height: 30,
              ),
              _submitButton(),
            ],
          ),
        ),
      ),
    ));
  }
}