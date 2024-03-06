import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'common.dart';
import 'connection.dart';
class UpdateProduct extends StatefulWidget {

  int product_id=0;

  UpdateProduct(this.product_id, {Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState(product_id);
}

class _UpdateProductState extends State<UpdateProduct> {
  int _productId=0;

  _UpdateProductState(int product_id){
    _productId=product_id;
  }

  MyNetworkRequest request = MyNetworkRequest();
  var response= [ { 'photo' : '' , 'title' : '' , 'price' : '' , 'detail' : '' } ] as List;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  String name="",detail="",photo="";
  int pageIndex = 0;
  int categoryId=0;
  int stock=0;
  int price=0;
  Color selectedColor = Colors.red;

  Color unselectedColor = Colors.white;

  //late Color currentColor;
  bool _selected = false;
  final picker = ImagePicker();
  String? _pickedImagePath;

  Future<String?> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      print('No image selected.');
      return null;
    }
  }




  getProductDetail() async {
    print("this is productid =$_productId");
    String url = 'product.php?productid=${_productId}';
    response = await request.SendRequest(url,"get");
    setState(() {
      response.removeAt(0);
      response.removeAt(0);
    });
    print("this is response of product $response");
    nameController.text = response[0]['title'];
    detailController.text = response[0]['detail'];
    stockController.text = response[0]['stock'];
    priceController.text = response[0]['price'];
    photoController.text = response[0]['photo'];
    categoryId = int.parse(response[0]['categoryid'].toString());
  }
  updateProduct() async {
    name = nameController.text.toString();
    detail = detailController.text.toString();
    photo = photoController.text.toString();

    // Check if stockController and priceController are not empty
    if (stockController.text.isNotEmpty && priceController.text.isNotEmpty) {
      // Check if stockController and priceController contain valid integer values
      if (int.tryParse(stockController.text) != null && int.tryParse(priceController.text) != null) {
        stock = int.parse(stockController.text.toString());
        price = int.parse(priceController.text.toString());

        String url = 'edite_product.php';
        var form = {};
       form['productid'] = _productId.toString();
       form['name'] = name.trim().toString();
       form['photo'] = photo.trim().toString();
       form['price'] = price.toString();
       form['stock'] = stock.toString();
        form['detail'] = detail.trim().toString();
        print("this is input form $form");

        var response = await request.SendRequest(url, 'post', form);
        print("response from server $response");
      } else {
        // Display error message for invalid integer values in stockController and priceController
        print('Please enter valid integer values for Stock and Price ');
      }
    } else {
      // Display error message for empty stockController or priceController
      print('Stock and Price cannot be empty');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetail();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF9F0EB),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Text(
                "Cake Detail",
                style: GoogleFonts.titilliumWeb(
                    textStyle: TextStyle(
                        color: Color(0xFF644734),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80),
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
      ),


      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 300,
                  width: 300,
                  child: PageView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(response[0]['photo'].toString()),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),

                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(response[0]['photo'].toString()),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20))),
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(response[0]['photo'].toString()),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20))),
                    ],

                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CarouselIndicator(
              color: Color(0xFFF16A6A),
              activeColor: Color(0xFFF1BDB0),
              count: 3,
              index: pageIndex,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 8,bottom: 5),
              child: TextFormField(

                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Product Name",
                    labelStyle: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Color(0xFF644734))),
                    floatingLabelStyle: TextStyle(color: Color(0xFFF16A6A)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFF16A6A),
                          width: 2
                      ),
                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 3,bottom: 5),
              child: TextFormField(
               maxLines: 3,
                controller: detailController,
                decoration: InputDecoration(
                    labelText: "Product Detail",
                    labelStyle: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Color(0xFF644734))),
                    floatingLabelStyle: TextStyle(color: Color(0xFFF16A6A)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFF16A6A),
                          width: 2
                      ),
                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 3,bottom: 5),
              child: TextFormField(

                controller: stockController,
                decoration: InputDecoration(
                    labelText: "Stock",
                    labelStyle: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Color(0xFF644734))),
                    floatingLabelStyle: TextStyle(color: Color(0xFFF16A6A)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFF16A6A),
                          width: 2
                      ),
                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 3,bottom: 5),
              child: TextFormField(

                controller: priceController,
                decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Color(0xFF644734))),
                    floatingLabelStyle: TextStyle(color: Color(0xFFF16A6A)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFF16A6A),
                          width: 2
                      ),
                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(

                      controller: photoController,
                      decoration: InputDecoration(
                          labelText: "Photo",
                          labelStyle: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Color(0xFF644734))),
                          floatingLabelStyle: TextStyle(color: Color(0xFFF16A6A)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xFFF16A6A),
                                width: 2
                            ),
                          )
                      ),

                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _pickImage(ImageSource.gallery).then((pickedImagePath) {
                        setState(() {
                          if (pickedImagePath != null) {
                            _pickedImagePath = pickedImagePath;
                            photoController.text = _pickedImagePath!;
                          }
                        });
                      });
                    },
                      child: Icon(Icons.camera_alt_outlined))
                ],
              ),
            ),

            Container(
              height: 100,
              width: 200,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                      updateProduct();
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF16A6A),
                          shape: StadiumBorder(),
                          elevation: 5,
                          minimumSize: Size(180, 40)),
                      child: Text(
                        "Update",
                        style: GoogleFonts.titilliumWeb(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF9F0EB),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
