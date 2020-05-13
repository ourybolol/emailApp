

import 'package:emailapp/ComposeButton.dart';
import 'package:emailapp/MessageCompose.dart';
import 'package:emailapp/MessageDetaill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:emailapp/Message.dart';

class MessageList extends StatefulWidget {
  final String title;
  final String status;

  const MessageList({Key key, this.title, this.status = 'important'}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {

  Future<List<Message>> future;
 
    //String content = await rootBundle.loadString('data/message.json');
    List<Message> messages;

  void initState(){
    super.initState();

    fetch();
  }

  void fetch() async {
    future = Message.browse(status: widget.status);
    messages = await future;
  }
 
  Widget build(BuildContext context) {
        
          return FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                 return Center(child: CircularProgressIndicator());
                case ConnectionState.done: 
                 if(snapshot.hasError) 
                  return Text("il y'avais une erreur : ${snapshot.error}");
                var messages = snapshot.data;
                  return  ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (context, index)=>Divider(),
                    itemBuilder:(BuildContext context , int index){
                    Message message = messages[index];

                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                       actions: <Widget>[
                          IconSlideAction(
                            caption: 'Archive',
                            color: Colors.blue,
                            icon: Icons.archive,
                            onTap: () {},
                          ),
                          IconSlideAction(
                            caption: 'Share',
                            color: Colors.indigo,
                            icon: Icons.share,
                            onTap: () {},
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'More',
                            color: Colors.black45,
                            icon: Icons.more_horiz,
                            onTap: () {},
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: (){
                              setState(() {
                                messages.removeAt(index);
                              });
                            },
                          ),
                        ],
                      child: ListTile(
                                   title: Text(message.subject),
                        trailing: CircleAvatar(),
                        isThreeLine: true,
                        leading: CircleAvatar(
                          child: Text('OB'),
                        ),
                        subtitle: Text(
                          message.body,
                         maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                              MessageDetail(message.subject, message.body),
                              ),
                              );
                          },
                      ), key: ObjectKey(message),
                    );
                  }
                  );
              };
            },
            );
         
          floatingActionButton: ComposeButton(messages);
          // This trailing comma makes auto-formatting nicer for build methods.
       
      }
    }


   