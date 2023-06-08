// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restapitest/post.dart';
import 'remote_event.dart';
import 'remote_bloc.dart';
import 'remote_state.dart';

void main() {
  runApp(
    Application(),
  );
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  final TextEditingController myController = TextEditingController();
  final bloc = RemoteBloc();
  List<description> tmp = List();

  @override
  void dispose() {
    myController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: TextField(
                controller: myController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Please input from 0-99 to get data",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ),
                  onPressed: () => bloc.eventSink.add(RemoteEvent(int.parse(myController.text))),
                  child: const Text(
                    "Get data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<RemoteState>(
              stream: bloc.stateStream,
              initialData: bloc.initialState,
              builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
                final RemoteState state = snapshot.data ?? bloc.initialState;
                if (snapshot.data.index != null && snapshot.data.index >= 0 && snapshot.data.index < state.postData.length) {
                    tmp = [state.postData[snapshot.data.index]];
                } 
                else {
                    tmp.clear();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tmp.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${tmp[0].userId}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${tmp[0].title}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


