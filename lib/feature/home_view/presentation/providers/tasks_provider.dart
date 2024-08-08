import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/local_storage/local_storage_hive.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  throw UnimplementedError();
});


final getTasksProvider = FutureProvider.autoDispose<List<String>>((ref){
  final localDb = ref.watch(localStorageProvider);
  return localDb.getAllTasks();

});