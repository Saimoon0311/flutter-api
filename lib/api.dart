import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getuser() async {
    var users = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData) {
      UsersModel user = UsersModel(i['name'], i['username'], i['email']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getuser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Text("no data "),
          );
        } else
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data[i].name),
                );
              });
      },
    ));
  }
}

class UsersModel {
  var name;
  var username;
  var email;

  UsersModel(this.name, this.username, this.email);
}
