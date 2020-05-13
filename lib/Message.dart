import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'Message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json)
   => _$MessageFromJson(json);


static Future<List<Message>> browse({ status = 'important'}) async{

  String url = status == 'important' 
          ?'http://www.mocky.io/v2/5eb9d23f2f00005e523c3403'
          : 'http://www.mocky.io/v2/5eb37fd032000059cc7b8917';

  http.Response response =
     await  http.get(url);

     //http://www.mocky.io/v2/5eb9d23f2f00005e523c3403

     await Future.delayed(Duration(seconds: 1));

     String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages =
     collection.map((json) => Message.fromJson(json)).toList();
   
    return _messages;
  
 } 
}