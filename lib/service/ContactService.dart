import 'dart:convert';

import 'package:emailapp/model/Contact.dart';
import 'package:http/http.dart' as http;


class ContactService {
  static String _url = "https://jsonplaceholder.typicode.com/users";
  static Future<List<Contact>> browse ({query}) async {
    http.Response response = await http.get(_url);

    await Future.delayed(Duration(seconds: 2));

    String content = response.body;

    List collection = json.decode(content);

    Iterable<Contact> _contacts =
    collection.map((_) => Contact.fromJson(_));

    if(query != null && query.isNotEmpty) {
       _contacts = _contacts.where((contact) => contact.name.toLowerCase().contains(query));
    }
    return _contacts.toList();
  }
}