import 'package:deliveryfood/entity/entity.dart';

class FoodResponse {
  List<Foods> yemekler; //foods list
  int success;

  FoodResponse({required this.yemekler, required this.success});

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    List<Foods> yemeklerListesi = jsonArray
        .map((jsonArrayObject) => Foods.fromJson(jsonArrayObject))
        .toList();
    int success = json["success"] as int;
    return FoodResponse(yemekler: yemeklerListesi, success: success);
  }
}
