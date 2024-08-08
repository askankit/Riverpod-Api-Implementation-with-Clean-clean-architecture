import 'package:dio/dio.dart';
import 'package:to_do_application/feature/home_view/data/model/photos_model.dart';

abstract class PhotosDataSource {
  Future<List<PhotosModel>?> getPhotos();
}
class PhotosDataSourceImpl extends PhotosDataSource{
  final _dio = Dio();

  @override
  Future<List<PhotosModel>?> getPhotos() async{
    try {
      final response = await _dio.get("https://jsonplaceholder.typicode.com/photos");
      print(response.toString());
      if(response.statusCode==200){
        final list = (response.data as List)
            .map((e) => PhotosModel.fromJson(e))
            .toList();
        return list;
      }else{
        return [];
      }
    } catch (e) {
      return null;
    }

  }
}