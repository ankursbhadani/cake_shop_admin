import 'package:cake_shop_admin/add_product.dart';
import 'package:cake_shop_admin/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common.dart';
import 'connection.dart';

class Cakes extends StatefulWidget {
  int response_id = 0;
  final Map<String, dynamic> category;

  Cakes({Key? key, required this.category}) {
    response_id = int.parse(category['id'].toString());
    print(response_id);
  }

  @override
  State<Cakes> createState() => _CakesState(response_id);
}

class _CakesState extends State<Cakes> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var response = [
    {'title': '', 'photo': '', 'price': '', 'detail': ''}
  ] as List;
  int responseId = 0;

  _CakesState(int response_id) {
    responseId = response_id;
  }

  MyNetworkRequest request = MyNetworkRequest();
  FlutterSecureStorage storage = FlutterSecureStorage();

  getProduct() async {
    String url = 'product.php?categoryid=${responseId}';
    response = await request.SendRequest(url, 'get');
    setState(() {
      response.removeAt(0);
      response.removeAt(0);
    });
  }

  Future<void> deleteProduct(responseId) async {
    String url = 'delete_product.php?id=${responseId}';
    var deletedResponse = await request.SendRequest(url, 'get');
    print('Deleted response: $deletedResponse');
    setState(() {
      // Remove the deleted product from the response list
      response.removeWhere((item) => item['id'] == responseId);
      getProduct();
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct(responseId)));
        },
        child: CircleAvatar(
          backgroundColor: Color(0xFFF1BDB0),
          radius: 30,
          child: Icon(
            Icons.add,
            color: Color(0xFF644734),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF9F0EB),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        productList: response.cast<Map<String, dynamic>>()));
              },
              icon: Icon(
                Icons.search,
                color: Color(0xFF644734),
              )),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Cakes",
                style: GoogleFonts.titilliumWeb(
                    textStyle: TextStyle(
                        color: Color(0xFF644734),
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFF1BDB0),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            height: 700,
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: ListView.builder(
                  key: _listKey,
                  itemCount: response.length,
                  itemBuilder: (context, index) {
                    return PopularCake(response[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget PopularCake(response) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UpdateProduct(int.parse(response['id'].toString()))));
      },
      child: ListTile(
        title: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFFFFFFF),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(response['photo'].toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 6.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        response['title'].toString(),
                        style: GoogleFonts.titilliumWeb(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF644734)),
                            height: 1),
                      ),
                      Text(
                        response['detail'].toString(),
                        style: GoogleFonts.titilliumWeb(
                            textStyle: TextStyle(
                                height: 1.0,
                                fontSize: 15,
                                color: Colors.black38)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "\u{20B9}" + response['price'].toString(),
                        style: GoogleFonts.titilliumWeb(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 40, right: 10),
                child: InkWell(
                    onTap: () {
                      deleteProduct(int.parse(response['id'].toString()));
                    },
                    child: Image.asset(
                      "assets/delete.png",
                      height: 35,
                      width: 35,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
