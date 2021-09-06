import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AddMails.dart';
import 'ViewEmail.dart';
class All_Mails extends StatefulWidget {
  const All_Mails({ Key key }) : super(key: key);

  @override
  _All_MailsState createState() => _All_MailsState();
}
FirebaseAuth _auth =FirebaseAuth.instance;
String email = _auth.currentUser.email.toString();
 DocumentSnapshot Maildata;
 var userData =[];
var fb =FirebaseFirestore.instance;
class _All_MailsState extends State<All_Mails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      leadingWidth: 30,
      
        iconTheme: IconThemeData(color: Colors.black),
        
title :Material(
          elevation: 8,
          child: TextFormField(
           
            
            decoration: InputDecoration(
            
                hintText: 'Search Mail',
                border: InputBorder.none,
               
                suffixIcon: InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: CircleAvatar(
                      child: Icon(Icons.person_sharp),
                    ),
                  ),
                )),
          ),
        ),

       
      
      ),

      drawer: Drawer(
        
        child: ListView(
          padding: const EdgeInsets.only(top:80,left: 10),
          children: [
             Center(child: Text("Gmail Clone",style:TextStyle(color:Colors.red,fontSize: 25))),
             SizedBox(height: 40),
              new Divider(),
              new ListTile(
                title: new Text(
                  'All inbox',
                  
                ),
                leading: Icon(Icons.all_inbox),
                 onTap: (){
                Navigator.pushNamed(context, '/allinbox');
              },
              ),
              
              new ListTile(
                title: new Text(
                  'Primary',
                ),
                leading: Icon(Icons.stay_primary_portrait),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              
              new ListTile(
                title: new Text(
                  'Social',
                  
                 
                ),
                leading: Icon(Icons.person_add),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new Divider(),
              SizedBox(height: 15,),
             
              Text("ALL LABLES"),
              new ListTile(
                title: new Text(
                  'All mails',
                  
                 
                ),
                leading: Icon(Icons.mail),
                 onTap: (){
                Navigator.pushNamed(context, '/allmails');
              },
              ),
              new ListTile(
                title: new Text(
                  'Starred',
                  
                 
                ),
                leading: Icon(Icons.star_border),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Snoozed',
                  
                 
                ),
                leading: Icon(Icons.schedule),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Important',
                  
                 
                ),
                leading: Icon(Icons.label_important),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
               
              
              new ListTile(
                title: new Text(
                  'Sent ',
                  
                 
                ),
                leading: Icon(Icons.send),
                 onTap: (){
                Navigator.pushNamed(context, '/sentbox');
              },
              ),
              
              
              new ListTile(
                title: new Text(
                  'Schedule',
                  
                 
                ),
                leading: Icon(Icons.schedule_send),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              
              
              new ListTile(
                title: new Text(
                  'Outbox',
                  
                 
                ),
                leading: Icon(Icons.outbox),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Draft',
                  
                 
                ),
                leading: Icon(Icons.drafts),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'spam',
                  
                 
                ),
                leading: Icon(Icons.dynamic_form),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
             new ListTile(
                title: new Text(
                  'Bin',
                  
                 
                ),
                leading: Icon(Icons.delete),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              SizedBox(height: 15),
              Text("GOOGLE APPS"),
              new ListTile(
                title: new Text(
                  'Calender',
                  
                 
                ),
                leading: Icon(Icons.calendar_today),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Contact',
                  
                 
                ),
                leading: Icon(Icons.person_sharp),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Settings',
                  
                 
                ),
                leading: Icon(Icons.settings),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
              },
              ),
              new ListTile(
                title: new Text(
                  'Help and feedback',
                  
                 
                ),
                leading: Icon(Icons.outbox),
                 onTap: (){
                Navigator.pushNamed(context, '/inbox');
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
        stream: fb.collection('inbox').where('from', isEqualTo: email, ).snapshots(),
        
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Center(child: Text('empty',style: TextStyle(color: Colors.grey),));
          }
          print(email);
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
               var userObject = {
                      "fromEmail" : "",
                      "toEmail" : "",
                      "mail" : "",
                      "subject" :""
                     };
                      userObject['subject'] = snapshot.data.docs[index]['subject'];
                userObject['toEmail'] = snapshot.data.docs[index]['receiver'];
                userObject['mail'] = snapshot.data.docs[index]['mail'];
                userObject['fromEmail'] = snapshot.data.docs[index]['from'];
                userData.add(userObject);
             
                              Maildata= snapshot.data.docs[index];
                             List data=snapshot.data.docs;
                             print(data);
                              // print(Maildata);
                           
              return InkWell(
                onTap: (){
                  print("hello");
                  Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewMales(data:userData[index],) ));
                  
                },
                child: ListTile(
                  leading: CircleAvatar(child: Text(Maildata['receiver'][0].toUpperCase()),),
                  title: Text(Maildata['subject'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  subtitle: Text(Maildata['mail']),
                  trailing: Text("09.00 pm"),
                ),
              );

          });
        },
      ),
              
    );

      
    
  }
}