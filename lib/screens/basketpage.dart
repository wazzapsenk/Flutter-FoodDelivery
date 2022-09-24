import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryfood/cubits/cubits.dart';
import 'package:deliveryfood/entity/entity.dart';
import 'package:deliveryfood/screens/screens.dart';


import '../services/auth.dart';

var isEmptyCart;
var cartSummary;

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    context
        .read<BasketPageCubit>()
        .loadFoodInCart("${FirebaseAuth.instance.currentUser?.email}");
    cartSummary = 0;
    isEmptyCart = false;
  }

  @override
  Widget build(BuildContext context) {
    return !isEmptyCart
        ? Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("SEPETİM",
          style: TextStyle(fontFamily: "Montserrat-Bold.ttf",fontSize: 20,fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: BlocBuilder<BasketPageCubit, List<FoodsInCart>>(
          builder: (context, foodList) {
            cartSummary = 0;
            for (var i = 0; i < foodList.length; i++) {
              cartSummary += int.parse(foodList[i].yemek_fiyat) *
                  int.parse(foodList[i].yemek_siparis_adet);
            }
            if (foodList.isNotEmpty) {
              return Column(

                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        var food = foodList[index];

                        return Card(

                          color: kBGColorGrey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 3,color: kPrimaryColor)),
                          margin:
                          EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              //Image
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${food.yemek_resim_adi}",
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              //Space
                              Container(
                                width: 30,
                              ),
                              //Piece and Price(total)
                              Column(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${food.yemek_siparis_adet} Adet ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat-Light.ttf",

                                            color: kTextColorDark),
                                      ),
                                      Text(
                                        " ${food.yemek_adi}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Montserrat-Light.ttf",
                                            fontWeight: FontWeight.bold,

                                            color: kTextColorDark),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Toplam Fiyat: ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat-Light.ttf",

                                            color: kTextColorDark),
                                      ),
                                      Text(
                                        "${int.parse(food.yemek_fiyat) * int.parse(food.yemek_siparis_adet)} ₺",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Montserrat-Light.ttf",
                                            fontWeight: FontWeight.bold,
                                            color: kTextColorDark),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //Space
                              Spacer(),
                              //Remove
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child:IconButton(style: IconButton.styleFrom(minimumSize: Size(50,50)),onPressed: (){
                                  ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Bu ürünü silmek istediğinize emin misiniz?"),
                                          action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              setState(() {
                                                print(foodList);
                                                context
                                                    .read<BasketPageCubit>()
                                                    .removeFood(
                                                    int.parse(food
                                                        .sepet_yemek_id),
                                                    "${FirebaseAuth.instance.currentUser?.email}");
                                              });

                                              if (foodList.length == 1) {
                                                setState(() {
                                                  isEmptyCart = true;
                                                  foodList.clear();
                                                });
                                              }
                                            },
                                          ),
                                        ));
                                },icon: Icon(Icons.delete_forever,color: kPrimaryColor,size: 35),)

                                // ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         primary: kPrimaryColor,
                                //         minimumSize: Size(60, 50)),
                                //     onPressed: () {
                                //       ScaffoldMessenger.of(context)
                                //           .showSnackBar(SnackBar(
                                //         content: Text(
                                //             "Bu ürünü silmek istediğinize emin misiniz?"),
                                //         action: SnackBarAction(
                                //           label: "Evet",
                                //           onPressed: () {
                                //             setState(() {
                                //               print(foodList);
                                //               context
                                //                   .read<BasketPageCubit>()
                                //                   .removeFood(
                                //                   int.parse(food
                                //                       .sepet_yemek_id),
                                //                   "${FirebaseAuth.instance.currentUser?.email}");
                                //             });
                                //
                                //             if (foodList.length == 1) {
                                //               setState(() {
                                //                 isEmptyCart = true;
                                //                 foodList.clear();
                                //               });
                                //             }
                                //           },
                                //         ),
                                //       ));
                                //     },
                                //     child: Text("Sil")),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //All Total Price
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Container(
                      width: 200,
                      height: 50,
                      color: Colors.transparent,
                      child: Text(
                        "Sepet Toplamı: ${cartSummary} ₺",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto-Regular.ttf",
                            fontWeight: FontWeight.bold,
                            color: kTextColorDark),
                      ),
                    ),
                  ),
                  //Approve order
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 60),
                            primary: kSecondaryColor),
                        onPressed: () {
                          for (var i = 0; i < foodList.length; i++) {
                            context.read<BasketPageCubit>().removeFood(
                                int.parse(foodList[i].sepet_yemek_id),
                                "${FirebaseAuth.instance.currentUser?.email}");
                          }
                          setState(() {
                            isEmptyCart = true;
                            foodList.clear();
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    icon: Icon(Icons.verified_outlined),
                                    iconColor: kSecondaryColor,
                                    backgroundColor: kTextColorWhite,
                                    shape:Border.symmetric(),
                                    title: Text("Sepet Onaylandı"),
                                    content:
                                    Text("Sepet Toplamı: ${cartSummary} ₺"),
                                    actions: [
                                      TextButton(
                                          child: Text("Tamam"),
                                          onPressed: () {
                                            Navigator.of(context).popUntil(
                                                    (route) => route.isFirst);
                                          })
                                    ]);
                              });
                        },
                        child: Text(
                          "Sepeti Onayla",
                          style: TextStyle(fontSize: 20, color: kTextColorWhite),
                        )
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sepetiniz boş"),
                    Container(
                      height: 50,
                    ),
                    Icon(Icons.local_mall, size: 100),
                  ],
                ),
              );
            }
          }),
    )
        : Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "SEPETİM",
            style: TextStyle(color: kTextColorWhite, fontSize: 20,fontFamily: "Montserrat-Bold.ttf"),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                  child: Container(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 250,
                    child: const Icon(Icons.shopping_bag,size: 50,color: kPrimaryColor,)
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: const Text(
                    "Sepetiniz Boş",
                    style: TextStyle(
                      color: kTextColorDark,
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => FoodsPage())));
                  }, child: const Text(
                    "Alışverişe devam etmek\niçin buraya tıklayın",
                    style: TextStyle(
                      color: kTextColorDark,
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
