import 'package:dartz/dartz.dart';
import 'package:to_do_application/feature/home_view/data/model/photos_model.dart';

import '../../../../core/error/failure.dart';
import '../respositores/photos_repo.dart';

abstract class PhotosUseCase<Type> {
  Future<Either<Failure, List<PhotosModel>?>> call();

}

class PhotosUseCaseImpl implements PhotosUseCase{
  final PhotosRepository repository;
  PhotosUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<PhotosModel>?>> call() async {
    final result = await repository.getPhotos();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
