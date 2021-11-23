// import 'package:http/http.dart';
import 'package:chopper/chopper.dart';
import 'package:recipie_finder/network/model_response.dart';
import 'package:recipie_finder/network/recipe_model.dart';

import 'model_converter.dart';
part 'recipe_service.chopper.dart';

const String apiKey = 'Your api key';
const String apiId = 'Your api url';
const String apiUrl = 'https://api.edamam.com';

@ChopperApi() //ells the Chopper generator to build a part file
abstract class RecipeService extends ChopperService {
  //RecipeService is an abstract class because you only need to define the method signatures. The generator script will take these definitions and generate all the code needed.
  @Get(path: 'search')
  //is an annotation that tells the generator this is a GET request
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
    //@Query annotation to accept a query string and from and to integers
    @Query('q') String query,
    @Query('from') int from,
    @Query('to') int to,
  );
  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$RecipeService(),
      ],
    );
    return _$RecipeService(client);
  }
}

//This is a request interceptor that adds the API key and ID to the query parameters.
Request _addQuery(Request req) {
  // 1
  final params = Map<String, dynamic>.from(req.parameters);
  // 2
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  // 3
  return req.copyWith(parameters: params);
}

// class RecipeService {
//   Future getData(String url) async {
//     print('Calling url: $url');
//     final response = await get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       print(response.statusCode);
//     }
//   }

//   Future<dynamic> getRecipes(String query, int from, int to) async {
//     final recipeData = await getData(
//         '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
//     return recipeData;
//   }
// }

//https://api.edamam.com/search?q=chicken&app_id=96078575&app_key=19c987c62720a28c82cb1036daa05ced&from=0&to=3&calories=591-722&health=alcohol-free"
