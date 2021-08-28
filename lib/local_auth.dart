import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


class LocalAuthApi {
  static final _auth =LocalAuthentication();
   static Future<bool> hasBiometric() async{
     try {
       return await _auth.canCheckBiometrics;
     } on PlatformException catch(e){
       return false;
     }
   }
   static Future<bool> authenticate() async{
     final isAvailable =await hasBiometric();
     if(!isAvailable) return false;
     try{
       return await _auth.authenticateWithBiometrics(localizedReason: "Scan fingerprint to authenticate",
     useErrorDialogs: true,
     stickyAuth: true);
     }
     catch(e){

     }
   }
}