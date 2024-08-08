import 'package:dartz/dartz.dart';

import 'package:to_do_application/core/error/failure.dart';

import 'package:to_do_application/feature/home_view/data/model/photos_model.dart';

import '../../domain/respositores/photos_repo.dart';
import '../data_source/get_photos_data_sources.dart';

class PhotosRepositoryImpl extends PhotosRepository{
  final PhotosDataSource dataSource;
  PhotosRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<PhotosModel>?>> getPhotos()async {
    try {
      final data = await dataSource.getPhotos();
      if(data?.isNotEmpty??false){
        return Right(data);
      }else{
        return const Left(ServerFailure(message: "Someting went Wrong"));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

}