import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository_implement.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features - posts

  //Bloc
  
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(addPost: sl(), deletePost: sl(), updatePost: sl()));



  //Usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));

  
  //Repositories
  sl.registerLazySingleton<PostRepository>(() =>
      PostRepositoryImplement(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImplements(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(connectionChecker: sl()));
  
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}