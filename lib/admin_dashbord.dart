import 'package:cake_shop_admin/productcategory.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'common.dart';
import 'connection.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F0EB),
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                title: Text(
                  "Welcome Mr. Admin! ",
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF644734)),
                ),
                subtitle: Text("Always Stay updated"),
              ),
            ),
            Container(
              height: 320,
              width: double.infinity,
              //color: Colors.lime,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        shape: CircleBorder(eccentricity: 1.0),
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(
                              isScrollControlled: true,
                                useSafeArea: true,
                                context: context, builder:(context)=>CackeMenu());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  // Start color
                                  const Color(0xFFF1BDB0),
                                  const Color(0xFFF9F0EB),



                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,

                              ),
                            ),
                            height: 150,
                            width: 150,
                            child: Center(
                              child: Text(
                                "Category",
                                style: GoogleFonts.titilliumWeb(
                                    fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF644734)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Card(
                        elevation: 10,
                        shape: CircleBorder(eccentricity: 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                // Start color
                                const Color(0xFFF1BDB0),
                                const Color(0xFFF9F0EB),



                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                            ),
                          ),
                          height: 150,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Order",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF644734)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        shape: CircleBorder(eccentricity: 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                // Start color
                                const Color(0xFFF1BDB0),
                                const Color(0xFFF9F0EB),



                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                            ),
                          ),
                          height: 150,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Users",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF644734)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Card(
                        elevation: 10,
                        shape: CircleBorder(eccentricity: 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                 // Start color
                                const Color(0xFFF1BDB0),
                                const Color(0xFFF9F0EB),



                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,

                            ),
                            borderRadius: BorderRadius.circular(20),

                          ),
                          height: 150,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Sales Report",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF644734)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
