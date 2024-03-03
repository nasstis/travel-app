import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app_view.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(
    this.userRepository, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthBloc>(
      create: (context) => AuthBloc(userRepository: userRepository),
      child: const MyAppView(),
    );
  }
}
