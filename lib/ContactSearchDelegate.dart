import 'package:emailapp/ContactListBuilder.dart';
import 'package:emailapp/ContactManager.dart';
import 'package:flutter/material.dart';

import 'model/Contact.dart';

class ContactSearchDelegate extends SearchDelegate {
  final manager;

  ContactSearchDelegate({this.manager});
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query = "";
        })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if(query.length < 3){
      return Center(
      child: Text("tape 3 lettres pour chercher"),
    );
    }

    return ContactListBuilder(
      stream: manager.filteredCollection(query: query),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }

}