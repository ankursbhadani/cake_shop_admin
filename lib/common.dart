
import 'package:cake_shop_admin/update_product.dart';
import 'package:cake_shop_admin/products.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'checkuser.dart';
import 'connection.dart';
PreferredSizeWidget? MyAppBar(){
  return AppBar(
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 45),
          child: Text(
            "Dashboard",
            style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(
                    color: Color(0xFF644734),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 55),
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/cakelogo_mini.png"),
                  ),
                  borderRadius: BorderRadius.circular(35))),
        )
      ],
    ),
    backgroundColor: Color(0xFFF1BDB0),
    centerTitle: true,

  );
}
void toast(message) {
  Fluttertoast.showToast(
      msg: message,
      fontSize: 20,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0xff214F94),
      textColor: Color(0xffF6B818));
}
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getProducts();
  }
MyNetworkRequest request = MyNetworkRequest();
dynamic response = [{"id":"15","title":"Rich Chocolate Photo Cake","price":"1025","photo":"assets\/chocolate.jpeg","detail":"Cake Flavour- Chocolate (Eggless), Weight- Half Kg, Type of Cake - Cream, Shape- Round"},{"id":"16","title":"Round Black Forest Photo Cake","price":"1250","photo":"assets\/Blackforest.jpg","detail":"Cake Flavour- Black Forest, Type of Cake- Cream, Weight- 1 Kg\r\nShape- Round, Serves- 10-12 People"}]as List;

getProducts() async {
  String url = 'product.php';
  response = await request.SendRequest(url,'get');
  setState(() {
    response.removeAt(0);
    response.removeAt(0);
  });
  print("This Is Comomon Response..$response");

}
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xFFF9F0EB),
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text(
                    'Admin',
                    style: GoogleFonts.titilliumWeb(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF644734)),
                  )),
              decoration: BoxDecoration(color: Color(0xFFF1BDB0)),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
              },
            ),
            ListTile(
              title: Text('Cake Menu'),
              onTap: () {
             //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CackeMenu()));
              },
            ),
            ListTile(
              title: Text('Most Populer Cake'),
              onTap: () {
               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cakes(category: response[11],)));
              },
            ),
            ListTile(
              title: Text('Privecy Policy'),
              onTap: () {
                //Navigator.of(context).push(PageTransition(
                  //  child: PrivecyPolicy(),
                    //type: PageTransitionType.leftToRight));
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
               // Navigator.of(context).push(PageTransition(child: AboutUs(), type: PageTransitionType.leftToRight));
              },
            ),
            ListTile(
              title: Text('LogOut'),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logoutUser();
              },
            ),
          ],
        )
    );
  }
}
class CustomSearchDelegate extends SearchDelegate <List <Map<String, dynamic>>>  {
  // Demo list to show querying
  final List<Map<String, dynamic>> productList;
  CustomSearchDelegate({required this.productList});
  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context,<Map<String, dynamic>>[]);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var product in productList) {
      if (product['title'].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['title'].toString()),
          // Add onTap functionality to navigate to product detail page
          onTap: () {
            // Navigate to product detail page with the selected product ID
           // Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var product in productList) {
      if (product['title'].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result['title'].toString()),
          // Add onTap functionality to navigate to product detail page
          onTap: () {
            // Navigate to product detail page with the selected product ID
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct(int.parse(result['id'].toString()))));
          },
        );
      },
    );
  }

}