import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryfood/repository/foodsdao_repo.dart';

class FoodDetailPageCubit extends Cubit<void> {
  FoodDetailPageCubit() : super(0);

  var foodrepo = FoodsDaoRepository();

  Future<void> AddFood(
      String yemek_adi,
      String yemek_resim_adi,
      int yemek_fiyat,
      int yemek_siparis_adet,
      String kullanici_adi) async {
    await foodrepo.addToCart(
        yemek_adi,
        yemek_resim_adi,
        yemek_fiyat,
        yemek_siparis_adet,
        kullanici_adi);
  }
}
