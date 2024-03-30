import 'package:schcol/models/recipe.dart';
import 'package:schcol/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final _httpService = HttpService();
  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "/recipes";
    if (filter.isNotEmpty) {
      path += "/meal-type/$filter";
    }
    var responce = await _httpService.get(path);
    if (responce!.statusCode == 200 && responce.data != null) {
      List data = responce.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      return recipes;
    }

    return null;
  }
}
