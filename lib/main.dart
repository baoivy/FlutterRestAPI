// @dart=2.9
import 'package:flutter/material.dart';
import 'package:restapitest/post.dart';
import 'package:restapitest/request.dart';

void main(){
    runApp(
        Application()
    );
}

class Application extends StatelessWidget {
    @override
    Widget build(BuildContext context){
        return MaterialApp(
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        );
    }
}

class MainPage extends StatefulWidget {
    @override
    MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
    List<description> postData = List();
    List<description> tmp = List();
    int index = 0;
    final TextEditingController myController = TextEditingController();

    @override
    void initState() {
      super.initState();
      fetch().then((dataFromServer) {
          setState(() {
              postData = dataFromServer;
          });
      });
    }
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myController.dispose();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              color: Colors.white,
              child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: TextField(
                            controller: myController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: const InputDecoration (
                                  labelText: "Please input from 0-99 to get data",
                                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child : SizedBox(
                              width: double.infinity,
                              height:50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))
                                  ),
                                  onPressed: changeIndex,
                                  child: const Text(
                                      "Get data",
                                      style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 16
                                      ),
                                  ),
                              )
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: tmp.length,
                              itemBuilder: ((context, index) {
                                  return Card(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                  Text('${tmp[0].userId}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                  )),
                                                  SizedBox(height: 5,),
                                                  Text('${tmp[0].title}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black
                                                  )),
                                              ],
                                          ),
                                      ),
                                  );
                              }
                          )
                        )      
                      )
                  ],
              )
          ),
      );
    }

    void changeIndex() {
      setState(() {
          tmp.clear();
          if(int.parse(myController.text) >= 0 && int.parse(myController.text) <= 99) {
              tmp.add(postData[int.parse(myController.text)]);
          }
      });
    }
}