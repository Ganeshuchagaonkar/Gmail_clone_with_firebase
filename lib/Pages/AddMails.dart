import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddMail extends StatefulWidget {
  @override
  _AddMailState createState() => _AddMailState();
}

class _AddMailState extends State<AddMail> {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  bool uploading =false;
  String receive;
  String mail;
  String subject;
  File imagepath;
  TextEditingController _receiver = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _mail = TextEditingController();
  pickimage(ImageSource imageSource) async {
    Navigator.pop(context);
    final imagefile = await ImagePicker()
        .pickImage(source: imageSource, maxHeight: 680, maxWidth: 970);
    setState(() {
      imagepath = File(imagefile.path);
    });
  }

  optionsdialog(econtext) {
    return showDialog(
        context: econtext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => pickimage(ImageSource.gallery),
                child: Text(
                  "Choose from gallery",
                  // style: mystyle(20, Colors.lightBlue),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickimage(ImageSource.camera),
                child: Text(
                  "Choose from camera",
                  // style: mystyle(20, Colors.lightBlue),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  // style: mystyle(20, Colors.lightBlue),
                ),
              )
            ],
          );
        });
  }

  // var imageid = Uuid().v4();

  // uploadimage() async {
  //   StorageUploadTask storageUploadTask =
  //       profile.child(imageid).putFile(imagepath);
  //   StorageTaskSnapshot storageTaskSnapshot =
  //       await storageUploadTask.onComplete;
  //   String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
  //   return downloadurl;
  // }


  sendEmail(String receiver,String subject, String mail )async {
    CollectionReference inbox =FirebaseFirestore.instance.collection('Inbox');
     FirebaseAuth _auth =FirebaseAuth.instance;
    String email = _auth.currentUser.email.toString();
   inbox.add({"receiver":receiver,"subject":subject,"mail":mail,"from":email}).then((value) => print(value));
    print("sending....");
    Navigator.of(context).pop();
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {

              receive = _receiver.text,
              subject =_subject.text,
              mail =_mail.text,
          sendEmail(receive, subject, mail)
        },
        child: Icon(Icons.send),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () => optionsdialog(context),
            child: Icon(Icons.attach_file, color: Colors.black),
          ),
        ],
        title: Text(
          'Compose email',
          // style: mystyle(20, Colors.black),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body:uploading==true?Center(child:Text("Sending mail....")) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .1,
              child: TextFormField(
                controller: _receiver,
                
                decoration: InputDecoration(
                  labelText: "To",
                 
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .1,
              child: TextFormField(
                controller: _subject,
                // style: mystyle(20, Colors.black, FontWeight.w500),
                decoration: InputDecoration(
                    labelText: "Subject", ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: _mail,
                  maxLines: null,
                  // style: mystyle(20, Colors.black, FontWeight.w600),
                  decoration: InputDecoration(
                      labelText: "Mail",
                    
                      border: InputBorder.none),
                ),
              ),
            ),
            imagepath == null
                ? Container()
                : MediaQuery.of(context).viewInsets.bottom > 0.0
                    ? Container()
                    : Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Your attachment",
                             
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              child: Image(
                                image: FileImage(imagepath),
                              ),
                            ),
                          ],
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
