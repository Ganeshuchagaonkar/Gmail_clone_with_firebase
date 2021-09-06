import 'package:flutter/material.dart';

class ViewMales extends StatefulWidget {
  var data;
  ViewMales({Key key, @required this.data}) : super(key: key);

  @override
  _ViewMalesState createState() => _ViewMalesState();
}

class _ViewMalesState extends State<ViewMales> {
  @override
  Widget build(BuildContext context) {
    print("View Mail :  ${widget.data}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_sharp),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    children: [
                      Icon(Icons.archive_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.email),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.delete),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.more_vert),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                      CircleAvatar(
                    child: Text(widget.data['fromEmail'][0].toUpperCase()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.data['fromEmail'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                   ],
                 ),
                 
                  Row(
                    children: [
                      Icon(Icons.keyboard_return),
                      Icon(Icons.more_vert),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Subject : ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: 250,
                      child: Text(
                        widget.data['mail'],
                        style: TextStyle(),
                      )),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "body :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Container(child: Text(widget.data['mail'])),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
