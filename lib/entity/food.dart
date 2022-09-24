class Foods {
  String yemek_id;//food_id
  String yemek_adi;//food_name
  String yemek_resim_adi;//food_img_name
  String yemek_fiyat;//food_price


  Foods({
    required this.yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
        yemek_id: json["yemek_id"] as String,
        yemek_adi: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String);
  }
}
