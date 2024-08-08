import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_application/feature/home_view/data/model/photos_model.dart';
import 'package:to_do_application/feature/home_view/data/respositories/photos_repo_impl.dart';

import '../../data/data_source/get_photos_data_sources.dart';
import '../../domain/respositores/photos_repo.dart';
import '../../domain/use_cases/get_photos_usecase.dart';

final showPassword = StateProvider.autoDispose<bool>((ref)=>false);

final useCaseProvider = Provider.autoDispose<PhotosUseCase>((ref){
  final repository = ref.watch(photosRepositoryProvider);
  return PhotosUseCaseImpl(repository: repository);
});


final photosRepositoryProvider = Provider.autoDispose<PhotosRepository>((ref){
  final dataSource = ref.watch(photosDataSource);
  return PhotosRepositoryImpl(dataSource: dataSource);
});
/// New comment
final photosDataSource = Provider.autoDispose<PhotosDataSource>((ref){
  return PhotosDataSourceImpl();
});

final photosProvider = FutureProvider.autoDispose<List<PhotosModel>>((ref)async{
  List<PhotosModel> list = [];
  final photosUseCase = ref.watch(useCaseProvider);
  final result = await photosUseCase.call();
  List<PhotosModel> res = result.fold((error) {
    return [];
  }, (result) {
    list.addAll(result!);
    return list;
  });
  return res;
}
);
