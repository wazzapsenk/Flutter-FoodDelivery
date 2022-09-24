
class FoodsInCart {

  String sepet_yemek_id; //food_id
  String yemek_adi; //food_name
  String yemek_resim_adi; //food_img_name
  String yemek_fiyat; //food_price
  String yemek_siparis_adet; //food_order_piece
  String kullanici_adi; //username
  FoodsInCart({
    required this.sepet_yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
    required this.yemek_siparis_adet,
    required this.kullanici_adi,
  });


  factory FoodsInCart.fromJson(Map<String, dynamic> json) {
    return FoodsInCart(
        sepet_yemek_id: json["sepet_yemek_id"] as String,
        yemek_adi: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String,
        yemek_siparis_adet: json["yemek_siparis_adet"] as String,
        kullanici_adi: json["kullanici_adi"] as String);
  }
}
