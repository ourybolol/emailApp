import 'package:flutter/material.dart';

import 'Message.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {

  String to = "";
  String subject = "";
  String body ="";

final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Compose New Message")
      ),
      body: SingleChildScrollView(
        child: Form( 
          key: key,
        child: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                validator: (value) =>  !value.contains('@') 
                ? "`To` field must be a valide email"
                : null,
                onSaved: (value) => to = value,
              decoration:  InputDecoration(
                prefixIcon: Icon(Icons.add),
                labelText: 'To',
                labelStyle: TextStyle(fontWeight: FontWeight.bold)
                 ),
            ),
            ),
           ListTile(
             title:  TextFormField(
               validator:  (value){
                 int len = value.length;
                 if (len == 0){
                   return "`SUBJECT` ne peut pas etre vide";
                 } else if (len < 4){
                   return "`SUBJECT`doit etre plus de 4 caractèeres";
                 }
                 return null;
               },
               onSaved: (value) => subject = value,
              decoration: InputDecoration(
                labelText: 'SUBJECT',
               labelStyle: TextStyle(fontWeight: FontWeight.bold)
               ),
            ),
           ),
           Divider(color: Colors.blue,),
            ListTile(
              
              title: TextFormField(
                onSaved: (value) => body = value,
                decoration:  InputDecoration(
                labelText: 'BODY',
                labelStyle: TextStyle(fontWeight: FontWeight.bold)
                 ),
              maxLines: 9,
            )
            ),
            ListTile(
              title: RaisedButton(
                color: Colors.blue,
                child: Text('Envoye'),
                onPressed: (){
                  if (this.key.currentState.validate()) {
                    this.key.currentState.save();
                    Message message = Message(subject,body);

                    Navigator.pop(context, message);
                  }
                   
                },
              )
            )
          ],
    
      ),
        ),
    ),
    );
  }
  
}
