import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/cubits/cubits.dart';
import 'package:deliveryfood/entity/entity.dart';
import 'package:deliveryfood/screens/basketpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FoodDetailPage extends StatefulWidget {
  Foods yemek;
  FoodDetailPage({
    required this.yemek,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<BasketPageCubit>().loadFoodInCart("${FirebaseAuth.instance.currentUser?.email}");
  }

  int yemek_siparis_adet = 1;
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            }),
        title:  Text("${widget.yemek.yemek_adi.toUpperCase()}",
          style: TextStyle(fontFamily: "Montserrat-Bold.ttf",fontSize: 20,fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
            ),
            Card(


                color: kPrimaryColor,
                shape: const CircleBorder(side: BorderSide(width: 400,color: kPrimaryColor,style: BorderStyle.solid)),

                child: Image.network(width: 200, height: 200, "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}")),
            Container(
              height: 10,
            ),
            Text(
              "${widget.yemek.yemek_adi}",
              style: TextStyle(fontFamily: "Montserrat-Medium.ttf",fontSize: 30,),
            ),
            Container(),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ücret :",style: TextStyle(fontFamily: "Montserrat-Medium.ttf",fontSize: 25,),),


                Text(
                  " ${widget.yemek.yemek_fiyat} ₺",
                  style: TextStyle(fontFamily: "Montserrat-Bold.ttf",fontSize: 25,fontWeight: FontWeight.bold,color: kTextColorDark ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),

              child: Container(
                height: 40,
                width:150,
                color: kSecondaryColor,
                padding: EdgeInsets.all(5),


                child:SizedBox(
                  height: 40,
                  width: 150,

                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                    Icon(Icons.download_rounded),

                    Text("Adet Seçiniz"),
                  ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 35,
                  color: kPrimaryColor,
                  onPressed: () {
                    setState(() {
                      if (yemek_siparis_adet == 1) {
                        return;
                      }
                      yemek_siparis_adet--;
                    });
                  },
                  icon: Icon(Icons.arrow_circle_down),
                ),
                Text(
                  "${yemek_siparis_adet}",
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  iconSize: 35,
                  color: kPrimaryColor,
                  onPressed: (() {
                    setState(() {
                      yemek_siparis_adet++;
                    });
                  }),
                  icon: Icon(Icons.arrow_circle_up),
                ),
              ],
            ),
            Container(
              height: 40,
            ),
            BlocBuilder<BasketPageCubit, List<FoodsInCart>>(builder: (context, yemeklerListesi) {
              return ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(minimumSize: Size(300, 60), primary: kSecondaryColor),
                  onPressed: () {
                    for (var i = 0; i < yemeklerListesi.length; i++) {
                      if (widget.yemek.yemek_adi == yemeklerListesi[i].yemek_adi) {
                        count = 0;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Bu Ürün Sepete Eklendi"),
                        ));
                        return;
                      }
                    }
                    if (count == 0) {
                      context.read<FoodDetailPageCubit>().AddFood(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi,
                          int.parse(widget.yemek.yemek_fiyat), yemek_siparis_adet, "${FirebaseAuth.instance.currentUser?.email}");
                      count--;

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text("Ürün Başarıyla Eklendi"),
                        action:

                        SnackBarAction(
                          label: "Sepete Git",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => BasketPage())));
                          },
                        ),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Bu Ürün Zaten Sepette !"),
                      ));
                    }
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: Text("Sepete Ekle"));
            }),
          ],
        ),
      ),
    );
  }
}