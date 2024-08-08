import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/get_photos_provider.dart';

class PhotosView extends ConsumerWidget {
  const PhotosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final toggle = ref.watch(showPassword);
    final photosData = ref.watch(photosProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text("Photos"),
          centerTitle: true,
        ),
/*      floatingActionButton: FloatingActionButton(
         onPressed: (){
           ref.read(showPassword.notifier).state = !ref.read(showPassword.notifier).state;
         },
      ),*/
        body: photosData.when(
            data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = data[index];
                    return ListTile(
                      title: Text(model.title ?? "",),
                      contentPadding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(model.thumbnailUrl??""),),);
                  },
                ),
            error: (error, stack) => Center(child: Text("=== $error ====")),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
