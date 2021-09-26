import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_api/models/newsinfo.dart';
import 'package:sample_api/service/api_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Future<NewsModel> _newsModel;


  void initState(){
    _newsModel = API_Manager().getNews();
    print(_newsModel.runtimeType);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("News App"),
        ),
        body: Container(
          color: Colors.red,
          child: FutureBuilder<NewsModel>(
            future: _newsModel,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(8),
                      color: Colors.green,
                      child: Row(
                        children: [
                          Card(

                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                  article.urlToImage,
                                  fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    article.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,

                                    ),
                                ),
                                Text(
                                    article.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),

                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                );

              }else{
                return Center(child: CircularProgressIndicator());
              }


            },

          ),
        ),
      ),
    );
  }
}
