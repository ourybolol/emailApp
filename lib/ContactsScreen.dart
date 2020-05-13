import 'package:emailapp/AppDrawer.dart';
import 'package:emailapp/ContactListBuilder.dart';
import 'package:emailapp/ContactManager.dart';
import 'package:emailapp/ContactSearchDelegate.dart';
import 'package:emailapp/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  ContactManager manager = ContactManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: <Widget>[
          Chip(
            label: StreamBuilder<int>(
              stream: manager.contactCounter,
              builder: (context, snapshot) {
                return Text(
                  (snapshot.data ?? 0).toString(),
                 style: TextStyle
                 (color: Colors.white,
                 fontWeight: FontWeight.bold),
                 );
              }
            ),
            backgroundColor: Colors.red,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: ContactSearchDelegate(manager: manager));
            }),
          Padding(padding: EdgeInsets.only(right: 16))
        ],
      ),
      drawer: AppDrawer(),
          body: ContactListBuilder(
            stream: manager.contactListNow,
            builder: (context, contacts){
              return ListView.separated(
              
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index){

                  Contact _contact = contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("OB")
                    ),
                    title: Text(_contact.name),
                    subtitle: Text(_contact.email),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
          );
            }
          )
    );
  }
}