import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'dart:async';
import './Page2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class Gadgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GadgetsState();
  }
}

class GadgetsState extends State<Gadgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1DC5C0),
        elevation: 0,
        title: Text('Comparison App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('header'),
              decoration: BoxDecoration(
                color: Color(0xFF1DC5C0),
              ),
            ),
            ListTile(
              title: Text('profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('buy'),
              onTap: () {},
            ),
            ListTile(
              title: Text('search'),
              onTap: () {},
            ),
            ListTile(
              title: Text('cart'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: GestureDetector(child: Subcat(), onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus&& currentFocus.focusedChild != null) {
            currentFocus.unfocus();
            }
            
            
           },),
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
  const urlpop ="https://aqueous-fortress-60483.herokuapp.com/popular/Mobile";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparison App',
      debugShowCheckedModeBanner: false,
      home: new Gadgets(),
      builder: EasyLoading.init(),
    );
  }
}

class Subcat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return (SubCatState());
  }
}

int i;

bool tapValue = false;

class SubCatState extends State<Subcat> {
  int tye = 0;
  List list = [];
  String currentText = "";
  var add1 = "";
  var item = [];
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  Future<void> fetchData1(String a) async {
    final String response =
        await rootBundle.loadString('assets/Sub-Categories.json');
    final data = await json.decode(response);
    setState(() {
      list = data[a];
    });
  }

  List pop=[];

  Future fetchpop() async{
    http.Response response;
    response = await http.get(urlpop);
    if (response.statusCode == 200) {
      setState(() {
        pop = json.decode(response.body);
        
      });
    }
  }

  

  List<String> suggestions = [
    "Mobiles under-10000",
    "Mobiles under-15000",
    "Mobiles under-20000",
    "Mobiles under-30000",
    "Mobiles above-50000",
    "under-10000 Mobiles",
    "under-15000 Mobiles",
    "under-20000 Mobiles",
    "under-30000 Mobiles",
    "above-50000 Mobiles",
    "TV 32-inches",
    "TV 40-inches",
    "TV 43-inches",
    "TV 50-inches",
    "32-inches TV",
    "40-inches TV",
    "43-inches TV",
    "50-inches TV",
    "TV Samsung Brand",
    "TV LG Brand",
    "TV TCL Brand",
    "TV Sanyo Brand",
    "TV MI Brand",
    "TV Onida Brand",
    "Mobiles Samsung Brand",
    "Mobiles Redmi Brand",
    "Mobiles Oppo Brand",
    "Mobiles Vivo Brand",
    "Mobiles Nokia Brand",
    "Mobiles Micromax Brand"
  ];

  // ignore: non_constant_identifier_names
  Widget Text1() {
    return SimpleAutoCompleteTextField(
        textInputAction: TextInputAction.search,
        
        key: key,
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Search",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
          labelText: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF1C3C9B),
          ),
        ),
        suggestions: suggestions,
        controller: TextEditingController(),
        textChanged: (text) => currentText = text,
        clearOnSubmit: true,
        textSubmitted: (text) => setState(() {
              if (text != "") {
                add1 = text;
                item.add(text.split(" "));
                print(item);

                switch (item[0][0]) {
                  case "TV":
                    {
                      if (item[0][2] == "Brand")
                        navigateToPage2("TV", item[0][1], 1);
                      else {
                        navigateToPage2("TV", item[0][1], 0);
                      }
                      item.clear();
                    }
                    break;
                  case "Mobiles":
                    {
                      if (item[0][2] == "Brand")
                        navigateToPage2("Mobiles", item[0][1], 1);
                      else {
                        navigateToPage2("Mobiles", item[0][1], 0);
                      }
                      item.clear();
                    }
                    break;
                  default:
                    {
                      if (item[0][0] == "Brand" ||
                          item[0][1] == "Brand" ||
                          item[0][2] == "Brand")
                        navigateToPage2(item[0][1], item[0][0], 1);
                      else {
                        navigateToPage2(item[0][1], item[0][0], 0);
                      }
                      item.clear();
                    }
                    break;
                }
              }
            }));
  }

  Timer _timer;

  Widget items(String name, String imgUrl, int pos) {
    return InkWell(
      onTap: () {
        setState(() {
          fetchData1(name);
        });
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Color(0xFF737373),
                height: 350,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                      )),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          "Sub categories",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        height: 25,
                      ),
                      Flexible(
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text(
                                  list[i],
                                ),
                                onTap: () async {
                                  _timer?.cancel();
                                  await EasyLoading.show(
                                    status: 'loading...',
                                    maskType: EasyLoadingMaskType.black,
                                  );

                                  navigateToPage2(list2[pos], list[i], 0);
                                },
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Image(
            image: NetworkImage(imgUrl),
            width: 170,
            height: 200,
            alignment: Alignment.center,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ]),
      ),
    );
  }

  Widget popular(String name, String imgUrl, int pos) {
    return InkWell(
      onTap: () {
        setState(() {
          fetchData1(name);
        });
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Image(
            image: NetworkImage(imgUrl),
            width: 170,
            height: 200,
            alignment: Alignment.center,
          ),
          Center(
            child: Text(""),
          )
        ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<String> ImgUrl = [
    'https://st.depositphotos.com/1265046/1328/i/600/depositphotos_13280842-stock-photo-tv-screen-white.jpg',
    'https://previews.123rf.com/images/tkm106/tkm1062005/tkm106200501000/147786472-photo-frame-smartphone-screen-transparent-material.jpg',
    'https://media.istockphoto.com/vectors/washing-machine-icon-vector-isolated-on-white-background-washing-vector-id1029730410',
    'https://cdn0.iconfinder.com/data/icons/elasto-electronics-and-appliances/26/05_hairdryer-512.png',
    'https://images.vexels.com/media/users/3/157345/isolated/preview/934008c8466ce089e15947cec0a7c61d-flat-laptop-icon-laptop-by-vexels.png',
  ];

  /* List<String> Category = [
    "Television",
    "Smart Phone",
    "Washing Machine",
    "Hair Dryer",
    "Laptop",
  ];
*/
/*  var sub = [
    ['32-inches', '40-inches', '42-inches', '50-inches'],
    ['Under-10000', '10000-15000', '15000-20000', '20000-30000', 'Above-30000'],
  ];*/

  // ignore: unused_element
  void _handleTap() {
    setState(() {
      i = 0;
    });
  }

  // ignore: unused_element
  void _handleTapPh() {
    setState(() {});
  }

  String appliance;
  String subcat;

  void navigateToPage2(String type, String sub, int tye) async {
    EasyLoading.dismiss();
    // ignore: unused_local_variable
    bool result = await Navigator.push(context,
        // ignore: non_constant_identifier_names
        MaterialPageRoute(builder: (Context) => Page2(type, sub, tye)));
  }

  List list2 = [];
  Future<void> fetchData() async {
    final String response = await rootBundle.loadString('assets/Category.json');
    final data = await json.decode(response);
    setState(() {
      list2 = data["Category"];
      for (int i = 0; i < list2.length; i++) {
        print(list2[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Comparison App');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left:10.0, right: 10.0), 
              child: Text1(),
            ),
          ),
          Container(
              height: 60,
              child: Text("\nCategories",
                  style: TextStyle(
                    fontSize: 18.72,
                  ))),
          Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[50],
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list2.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: items(list2[index], ImgUrl[index], index),
                      elevation: 10,
                    );
                  })),
          Container(
              height: 60,
              child: Text("\n Popular items",
                  style: TextStyle(
                    fontSize: 18.72,
                  ))),
          Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[50],
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list2.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: popular(list2[index], ImgUrl[1], index),
                      elevation: 10,
                    );
                  })),
        ],
      ),
    ));
  }

  String nextMat(String t) {
    if (i == 0) {
      return "TV";
    } else {
      return "Mobiles";
    }
  }
}