
import 'package:firebase_auth/firebase_auth.dart';




Future<User> createAccount(String name,String email,String password) async{
 
  FirebaseAuth _auth =FirebaseAuth.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  
  try{
    User user= (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(user !=null){
      print("Register Successfull");
      
      return user;
    }
    else{
      print("Account creation failed");
      return user;
    }
  }catch(e){
    print(e);
    return e;
  }
}

Future<User> logIn(String email, String password)async{
  
  FirebaseAuth _auth =FirebaseAuth.instance;
  try{
User user =(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

if(user != null){
  print("Login Successfull");
  return user;
}
else{
  
  print("Registration  failed");
 
  return user;
}
  }catch(e){
    
    print(e);
    return e;

  }
}

Future logout()async{
  FirebaseAuth _auth =FirebaseAuth.instance;
  try{
   await _auth.signOut();
  }catch(e){
    print("error");

  }
}