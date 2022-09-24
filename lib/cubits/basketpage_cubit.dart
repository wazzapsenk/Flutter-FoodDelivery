import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryfood/entity/food_cart.dart';
import 'package:deliveryfood/repository/foodsdao_repo.dart';

class BasketPageCubit extends Cubit<List<FoodsInCart>> {
  BasketPageCubit() : super(<FoodsInCart>[]);

  var foodrepo = FoodsDaoRepository();

  Future<void> loadFoodInCart(String kullanici_adi,) async {
    var liste = await foodrepo.getFoodsInCart(kullanici_adi);
    emit(liste);
  }

  Future<void> removeFood(int sepet_yemek_id, String kullanici_adi) async {
    await foodrepo.removeFromCart(sepet_yemek_id, kullanici_adi);
    await loadFoodInCart(kullanici_adi);
  }
}
