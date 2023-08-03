import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream/bloc/stream_bloc.dart';
import 'package:stream/repositry/modelclass/Streammodel.dart';
import 'package:stream/ui/screen2.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

late List<Streammodel> streams;

class _screen1State extends State<screen1> {
  void initState() {
    BlocProvider.of<StreamBloc>(context).add(FetchStream());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: CircleAvatar(
              radius: 10, backgroundImage: AssetImage("asset/bitcoin.png")),
          title: Text(
            "Bitcoin live updates",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "CAROS",
                color: Colors.red),
          ),
        ),
        body: BlocBuilder<StreamBloc, StreamState>(builder: (context, state) {
          if (state is StreamLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StreamError) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<StreamBloc>(context).add(FetchStream());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .9,
                    // color: Colors.red,
                    child:
                        const Center(child: Text('Oops something went wrong'))),
              ),
            );
          }
          if (state is StreamLoaded) {
            streams = BlocProvider.of<StreamBloc>(context).streammodel;
            return ListView.builder(
                itemCount: streams.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 325,
                      width: 325,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.blue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset("asset/bitcoin.png"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (CTX) => screen2(
                                        url: streams[index].url.toString(),
                                      )));
                            },
                            child: Text(
                              "Title: ${streams[index].title.toString()}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "description: ${streams[index].description.toString()}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "url: ${streams[index].url.toString()}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "date: ${streams[index].date.toString()}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ));
                });
          } else {
            return SizedBox();
          }
        }));
  }
}
