import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/manager/auth/auth_cubit.dart';
import 'features/presentation/manager/note/note_cubit.dart';
import 'features/presentation/manager/user/user_cubit.dart';
import 'features/presentation/pages/home_page.dart';
import 'features/presentation/pages/sign_in_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

import 'on_generate_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        initialRoute: '/',
        onGenerateRoute:OnGenerateRoute.route,
        routes: {
          "/": (context){
            return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){
              if (authState is Authenticated){
                return HomePage(uid: authState.uid,);
              }
              if (authState is UnAuthenticated){
                return const SignInPage();
              }
              return const CircularProgressIndicator();
            });
          }
        },
      ),
    );
  }
}
