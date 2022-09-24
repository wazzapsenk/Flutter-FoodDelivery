import 'dart:convert';
import 'package:deliveryfood/entity/entity.dart';
import 'package:http/http.dart' as http;

class FoodsDaoRepository {
  List<Foods> parseFoodsResponse(String response) {
    return FoodResponse.fromJson(json.decode(response)).yemekler;
  }

  List<FoodsInCart> parseFoodsInCartResponse(String response) {
    return FoodsInCartResponse.fromJson(json.decode(response)).sepet_yemekler;
  }

  Future<List<Foods>> getAllFoods() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var response = await http.get(url);
    return parseFoodsResponse(response.body);
  }

  Future<List<FoodsInCart>> getFoodsInCart(String kullanici_adi) async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var data = {"kullanici_adi": kullanici_adi};
    var response = await http.post(url, body: data);
    return parseFoodsInCartResponse(response.body);
  }

  Future<void> addToCart(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var data = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yemek_siparis_adet.toString(),
      "kullanici_adi": kullanici_adi
    };

    var response = await http.post(url, body: data);
  }

  Future<void> removeFromCart(int sepet_yemek_id, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var data = {
      "sepet_yemek_id": sepet_yemek_id.toString(),
      "kullanici_adi": kullanici_adi
    };
    var response = await http.post(url, body: data);
  }
}
