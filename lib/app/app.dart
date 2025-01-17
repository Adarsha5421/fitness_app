import 'package:fitness_tracker/app/di/di.dart';
import 'package:fitness_tracker/core/theme/app_theme.dart';
import 'package:fitness_tracker/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:fitness_tracker/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:fitness_tracker/features/splash/presentation/view/splash_view.dart';
import 'package:fitness_tracker/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => getIt<SplashCubit>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koselie',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
