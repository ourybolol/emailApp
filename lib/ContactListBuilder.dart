import 'package:flutter/material.dart';

import 'model/Contact.dart';

 class ContactListBuilder extends StatelessWidget {
   final Stream<List<Contact>> stream;
   final Function builder;

  const ContactListBuilder({ this.stream, this.builder}) ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<Contact>>(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                 return Center(child: CircularProgressIndicator());
                case ConnectionState.done: 
              List<Contact> contacts = snapshot.data;

              return builder(context, contacts);

              }
            }
          );
  }

}