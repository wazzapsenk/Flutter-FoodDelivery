import 'package:deliveryfood/entity/entity.dart';

class FoodsInCartResponse {
  List<FoodsInCart> sepet_yemekler; //foodsincart
  int success;

  FoodsInCartResponse({required this.sepet_yemekler, required this.success});

  factory FoodsInCartResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    List<FoodsInCart> sepetYemekler =
        jsonArray.map((object) => FoodsInCart.fromJson(object)).toList();

    return FoodsInCartResponse(
        sepet_yemekler: sepetYemekler, success: json["success"] as int);
  }
}
