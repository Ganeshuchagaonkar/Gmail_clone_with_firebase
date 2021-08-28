import 'package:flutter/material.dart';

import 'Pages/mails.dart';
import 'local_auth.dart';



class FingerPrint extends StatefulWidget {
  const FingerPrint({ Key key }) : super(key: key);

  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           InkWell(
             onTap: (){
             print("hello");
             },
             child: Padding(
               padding: const EdgeInsets.only(left:20.0,right: 20),
               child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
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
                color: Colors.blueAccent
                
                    ),
        child: Text(
          'CheckAvailiability',
          style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
             ),
           ),
              InkWell(
             onTap: ()async{
             final isAuthenticate =await LocalAuthApi.authenticate();
                          if(isAuthenticate){
                            Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MailsPage()));
                          }
             },
             child: Padding(
               padding: const EdgeInsets.only(left:20.0,right: 20,top: 20),
               child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
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
                color: Colors.blueAccent
                
                    ),
        child: Text(
          'Authenticate',
          style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
             ),
           ),

          ],
        ),
      ),
      
    );
  }
}
