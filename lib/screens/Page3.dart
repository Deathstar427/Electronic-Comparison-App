import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:flutter/src/widgets/text.dart';

class Page3 extends StatefulWidget {
  final List<int> list3;
  final String urlPage3;
  final String tl;
  Page3(this.list3, this.urlPage3, this.tl);

  @override
  _Page3State createState() => _Page3State(list3, urlPage3, tl);
}

class _Page3State extends State<Page3> {
  final List<int> list3;
  final String urlPage3;
  final String tl;

  _Page3State(this.list3, this.urlPage3, this.tl);

  List list4;
  final List list5 = [
    "display",
    "Color",
    "Dimensions",
    "weight",
    "FrontCamera",
    "RearCamera",
    "Battery",
    "WirelessComm",
    "Model",
    "Price",
    "Accessories",
    "Ratings",
    "Review"
  ];
  int flag = 1;
  int indexx;
  List list6 = [
    "Brand",
    "Size",
    "Resolution",
    "Weight",
    "Model",
    "Ratings",
    "Review",
    "Price"
  ];
  List whichList(String t1) {
    if (t1 == "TV")
      return list6;
    else
      return list5;
  }

//List<String> list7 = whichList(tl);

  Future fetchData() async {
    http.Response response;

    response = await http.get(urlPage3);
    if (response.statusCode == 200) {
      setState(() {
        list4 = json.decode(response.body);
      });
    }
    
  }

  @override

  // @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container( color: Colors.black12,
                          child: CustomScrollView(
          slivers: [
               SliverAppBar( automaticallyImplyLeading: true,
                leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: (){
              Navigator.pop(context,false);
              
            }
            ),
                backgroundColor: Color(0xFF1DC5C0),
                floating: false,
                pinned: true,
                expandedHeight: 10,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Comparison App"),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildListDelegate([
                  Container(
                    child: list4 == null
                        ? Container()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0, right: 20),
                              child: Text(
                                list4[list3[0]]["Title"],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ),
                    color: Colors.grey[300],
                  ),
                  Container(
                    child: list4 == null
                        ? Container()
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0, right: 20),
                              child: Text(
                                list4[list3[1]]["Title"],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ),
                    color: Colors.grey[200],
                  ),
                ]),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: list4 == null
                            ? Container()
                            : Text(
                                printd(list4, whichList(tl)[indexs(index)],
                                            index) ==
                                        null
                                    ? ""
                                    : printd(list4, whichList(tl)[indexs(index)],
                                        index),
                              ));
                  },
                  childCount: (whichList(tl).length) * 2,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 3.0,
                ),
              ),
              
              SliverGrid(delegate: SliverChildBuilderDelegate(
                (context,index){
                  return Container( color: Colors.black12,
                    child: Center( child: ElevatedButton(child: Text("Buy Now"), onPressed: (){}, style: ElevatedButton.styleFrom( primary: Color(0xFF1C3C9B),), )
                    ),
                      
                  );
                },
                childCount: 2

              ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 0,
                childAspectRatio: 3.0,
              ),
              )

          ],  
        ),
            ),
         bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
         ),
        ),);
  }

  String printd(List a, String x, int index) {
    if (index % 2 == 0) {
      return a[list3[0]][x];
    } else if (index % 2 == 1) {
      return a[list3[1]][x];
    }
  }

  int indexs(int indexx) {
    //indexx++;
    double deci = indexx / 2;
    int y = deci.floor();
    return y;
  }
}
