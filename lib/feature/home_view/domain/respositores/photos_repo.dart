import 'package:dartz/dartz.dart';
import 'package:to_do_application/feature/home_view/data/model/photos_model.dart';

import '../../../../core/error/failure.dart';

abstract class PhotosRepository {
  Future<Either<Failure, List<PhotosModel>?>> getPhotos();
}