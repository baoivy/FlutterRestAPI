// @dart=2.9
import 'package:flutter/material.dart';
import 'package:restapitest/post.dart';
import 'remote_event.dart';
import 'remote_bloc.dart';
import 'remote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  const MainPage({Key key}) : super(key: key);
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final TextEditingController myController = TextEditingController();
  final RemoteBloc bloc = RemoteBloc();

  @override
  void dispose() {
    myController.dispose();
    bloc.close();
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
                  onPressed: () =>
                      bloc.add(LoadEvent(int.parse(myController.text))),
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
            BlocBuilder<RemoteBloc, RemoteState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is LoadedState) {
                  List<description> tmp = state.postData;
                  if (state.index != null && state.index >= 0 && state.index < state.postData.length) {
                    tmp = [state.postData[state.index]];
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
                                  '${tmp[index].userId}',
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
                } else if (state is ErrorState) {
                  return Text(
                    'Error: ${state.error}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
