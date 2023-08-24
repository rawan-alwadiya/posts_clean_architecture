import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecture/core/app_theme.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository_implement.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'injection_container.dart' as di;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=> di.sl<PostsBloc>()),
          BlocProvider(create: (_)=> di.sl<AddDeleteUpdatePostBloc>()),
        ],
        child: MaterialApp(
      showSemanticsDebugger: false,
      title: 'Posts App',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts App'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    ));
  }
}
