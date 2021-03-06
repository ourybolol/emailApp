import 'dart:async';

import 'package:emailapp/model/Contact.dart';
import 'package:emailapp/service/ContactService.dart';


class ContactManager {
  final StreamController<int> _contactCounter = StreamController<int>();
  Stream<int> get contactCounter => _contactCounter.stream;

  Stream<List<Contact>> get contactListNow  =>
      Stream.fromFuture(ContactService.browse()) ;
  
  Stream<List<Contact>> filteredCollection({query})  =>
      Stream.fromFuture(ContactService.browse(query: query)) ;
  

  ContactManager(){
    contactListNow.listen((list) => _contactCounter.add(list.length));

  }
}