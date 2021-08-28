// import 'package:login/Signup.dart';
import 'package:flutter/material.dart';
import 'package:login/Pages/mails.dart';
import 'package:login/Signup.dart';
import 'package:login/fingerprint.dart';
import 'package:login/local_auth.dart';
import 'package:login/methods.dart';


class LoginPage extends StatefulWidget {

 
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
 bool isloading =false;

class _LoginPageState extends State<LoginPage> {

  
 
  String email;
  String password;
 

  
  final TextEditingController _userNameController= TextEditingController();
  final TextEditingController _passController = TextEditingController();


  Widget _submitButton() {
    return GestureDetector(
      onTap: () =>{
        
        if(formKeylog.currentState.validate()){
          setState((){
            isloading=true;
          }),
        email =_userNameController.text,
        password= _passController.text,
    
        logIn(email, password).then((user) {
          if(user != null){
            print("Login successfull");
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content:const Text("Loged in Successfully..!",style: TextStyle(fontWeight: FontWeight.bold),),
          
         behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
       
        ));
          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FingerPrint()));
                              

            setState(() {
                        isloading=false;  
                        });


          }
          
        })
        }
        else{
          print("form is not validated")
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
          'Login',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  bool _isHidden = true;
  final formKeylog = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: new Container(
          padding:
              EdgeInsets.only(top: 120, right: 30.0, left: 30.0, bottom: 60.0),
          child: Form(
              key: formKeylog,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                   
                    SizedBox(
                      height: 30.0,
                    ),
                    new Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                         return "This field is Required";
                        }
                        return null;
                      },
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                       
                        hintText: 'Enter you email',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }

                       
                        return null;
                      },
                   
                      obscureText: _isHidden,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility_off),
                         border: InputBorder.none,
                        
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                       
                        hintText: 'Password',
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  
                   
                    
                    Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "forgot password?",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                   

                    SizedBox(
                      height: 20.0,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text("Don't have an account?"),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()));
                                },
                                child: Container(
                                  child: new Text(
                                    "SIGN UP",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}