import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import "./Page3.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


const url = "https://aqueous-fortress-60483.herokuapp.com";

class Page2 extends StatefulWidget {
  final String ty, sub;
  final int tye;
  Page2(this.ty, this.sub, this.tye);

  @override
  _Page2State createState() => _Page2State(ty, sub, tye);
}

class _Page2State extends State<Page2> {
   Timer _timer;
  double _progress;
  String ty, sub;
  int t;
  _Page2State(this.ty, this.sub, this.t);

  // ignore: missing_return
  String getURL(String type, String subcat, int t) {
    switch (type) {
      case "TV":
        {
          if (t == 1) {
            return url + "/listTVs/" + subcat;
          } else {
            return url + "/listTVs/size/" + subcat;
          }
        }
        break;
      case "Mobiles":
        {
          if (t == 1) {
            return url + "/listMobiles/" + subcat;
          } else {
            return url + "/listMobiles/price/" + subcat;
          }
        }
        break;
    }
  }

  List<int> _selectedItems = <int>[];
  List list2;
  String urlP3;
  Future fetchData() async {
    http.Response response;
    urlP3 = getURL(ty, sub, t);
    print(urlP3);
    response = await http.get(urlP3);
    if (response.statusCode == 200) {
      setState(() {
        list2 = json.decode(response.body);
      });
    }
  }

  void navigateToPage3(List<int> list1, String urlP3, String ty) async {
    // ignore: unused_local_variable
    bool result = await Navigator.push(context,
        // ignore: non_constant_identifier_names
        MaterialPageRoute(builder: (Context) => Page3(list1, urlP3, ty)));
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: (){
              Navigator.pop(context,false);
              
            }
            ),
            backgroundColor: Color(0xFF1DC5C0),
            elevation: 0,
            title: Text('Comparison App'),
          ),
          body: SafeArea(
            
            child: SingleChildScrollView(
              child: list2 == null
                  ? Container()
                  : Column(children: <Widget>[
                      Text(
                        ty,
                        style: TextStyle(
                            fontSize: 25, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String star =
                              list2[index]["Review"].toString().substring(0, 3);
                          var star2 = double.parse(star);
                          return Card( elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    color: (_selectedItems.contains(index))
                                        ? Colors.blue.withOpacity(0.5)
                                        : Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 10.0),
                                          child: InkWell(
                                              //  onTap: () {
                                              //   print("Clicked");
                                              // },
                                              child: ListTile(
                                                horizontalTitleGap: 10,
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7.0)),
                                                  child: Image.network(
                                                    'https://st.depositphotos.com/1265046/1328/i/600/depositphotos_13280842-stock-photo-tv-screen-white.jpg',
                                                  ),
                                                ),
                                                title: Text(
                                                    list2[index]['Title']
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 17)),
                                                subtitle: Column(
                                                  children: [
                                                    Text(
                                                        "Ratings - " +
                                                            list2[index]
                                                                    ["Review"]
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.left),
                                                    RatingBarIndicator(
                                                      rating: star2,
                                                      itemBuilder: (_, __) {
                                                        return Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xff1c3c9b),
                                                        );
                                                      },
                                                      itemSize: 25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                if (!_selectedItems
                                                    .contains(index)) {
                                                  setState(() {
                                                    print("Selected");
                                                    _selectedItems.add(index);
                                                  });
                                                } else {
                                                  setState(() {
                                                    _selectedItems
                                                        .remove(index);
                                                  });
                                                }
                                              }),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey[400],
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  )));
                        },
                        itemCount: list2 == null ? 0 : list2.length,
                      ),
                    ]),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 5.0,
            icon: const Icon(Icons.compare),
            label: const Text('\tCompare\t'),
            backgroundColor: Color(0xff1c3c9b),
            onPressed: () async {
              for (int i = 0; i < _selectedItems.length; i++) {
                print(_selectedItems[i]);
              }

              for (int i = 0; i < _selectedItems.length; i++) {
                print(_selectedItems[i]);
              }
              print("Donee");
              call();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }

  void call() async {
    setState(() {
      if (_selectedItems.length > 2) {
        _selectedItems.clear();
        EasyLoading.showError('Only 2 Selections Allowed');
      } else {
        if (_selectedItems.length < 2) {
          EasyLoading.showInfo('Select 2 items from List');
          print('Select Atleast 2 items');
        } else {
             _progress = 0;
          _timer?.cancel();
          _timer =
              Timer.periodic(const Duration(milliseconds: 120), (Timer timer) {
            EasyLoading.showProgress(_progress,
                status: '${(_progress * 100).toStringAsFixed(0)}%');
            _progress += 0.03;

            if (_progress >= 1) {
              _timer?.cancel();
              EasyLoading.dismiss();
            }
          });

          navigateToPage3(_selectedItems, urlP3, ty);
        }
      }
    });
  }
}