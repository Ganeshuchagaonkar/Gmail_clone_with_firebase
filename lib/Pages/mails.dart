import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/Pages/AddMails.dart';



class MailsPage extends StatefulWidget {
  @override
  _MailsPageState createState() => _MailsPageState();
}

class _MailsPageState extends State<MailsPage> {
  String profilepic = '';
  String currentemail;
  Stream mystream;
  DocumentSnapshot Maildata;
  var fb =FirebaseFirestore.instance;

  // @override
  // void initState() { 
  //   super.initState();
  //   fetchUserData();
  // }

  // fetchUserData(){
  //   FirebaseAuth _auth =FirebaseAuth.instance;
  //   String name = _auth.currentUser.e.toString();
  // }

  
  
           
 
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      leadingWidth: 30,
      
        iconTheme: IconThemeData(color: Colors.black),
        
title :Material(
          elevation: 8,
          child: TextFormField(
           
            // onFieldSubmitted: (s) => searchmail(s),
            decoration: InputDecoration(
            
                hintText: 'Search Mail',
                border: InputBorder.none,
               
                suffixIcon: InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: CircleAvatar(
                      child: Text("P"),
                    ),
                  ),
                )),
          ),
        ),

       
      
      ),

      drawer: Drawer(
        
        child: ListView(
          children: [
             SizedBox(height: 40),
              new Divider(),
              new ListTile(
                title: new Text(
                  'Home',
                 
                ),
                 onTap: (){
                Navigator.pushNamed(context, '/Admin/Home');
              },
              ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddMail())),
        child: Icon(
          Icons.add,
          size: 45,
          color: Colors.red,
        ),
      ),
      body:StreamBuilder(
        stream: fb.collection('Inbox').snapshots(),
        
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          print(snapshot.data.docs);
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
             
                              Maildata= snapshot.data.docs[index];
                           
              return ListTile(
                leading: CircleAvatar(child: Text(Maildata['receiver'][0].toUpperCase()),),
                title: Text(Maildata['subject'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text(Maildata['mail']),
                trailing: Text("09.00 pm"),
              );

          });
        },
      ),
              
    );
  }
}
