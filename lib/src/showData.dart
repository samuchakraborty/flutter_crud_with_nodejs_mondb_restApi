import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_crud/services/networkHelper.dart';
import 'package:flutter_crud/src/Update.dart';

import 'insertData.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Show All Data'),
        actions: [IconButton(
            icon: Icon(Icons.add, color: Colors.black,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Insert()));


            }
        )
        ],


      ),
      body: FutureBuilder(
        future: Network().getAllPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  // print("hello");
                  // print(snapshot.data);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUI(
                            firstName: snapshot.data[index]['firstName'],
                            lastName: snapshot.data[index]['lastName'],
                            mobile: snapshot.data[index]['mobile'],

                          ),
                        ),
                      );
                    },
                    // onLongPress: () {
                    //   Network().deleteItem(
                    //       articleTitle: snapshot.data[index]['title'],
                    //       data: snapshot.data[index]['title']);
                    // },
                    child: Card(
                      elevation: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [

                              Image.memory(base64.decode(snapshot.data[index]["image"].toString()),
                              width: 100,
                                height: 50,
                              ),



                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data[index]['firstName'].toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Text(
                                    snapshot.data[index]['lastName'].toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  Text(
                                    snapshot.data[index]['mobile'].toString(),
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  //  Text(snapshot.data[index]['content'])
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _delete(
                                  articleTitle: snapshot.data[index]['firstName'],
                                  data: snapshot.data[index]['firstName']);
                            },
                            child: Icon(
                              Icons.auto_delete,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  void _delete({articleTitle, data}) async {
    //  var data = {'title': mobile, 'content': password};

    var res =
        await Network().deleteItem(articleTitle: articleTitle, data: data);
    // var body = json.decode(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => ViewData()),
      );
    }
  }
}
