// lib/main.dart

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main.g.dart';

// =========================================================
// MODEL (Profile)
// =========================================================

@JsonSerializable()
class Profile {
  final int userId;
  final int id;
  final String title;
  final String body;

  Profile({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}


// RETROFIT CLIENT

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/posts/1")
  Future<Profile> getProfile();
}


// API SERVICE

class ApiService {
  late RestClient client;

  ApiService() {
    final dio = Dio();
    client = RestClient(dio);
  }
}

// BLOC — EVENTS


abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}


// BLOC — STATES


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}


// BLOC — LOGIC


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService api;

  ProfileBloc(this.api) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await api.client.getProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}


// PROFILE PAGE (UI)


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(ApiService())..add(LoadProfile()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileLoaded) {
              final p = state.profile;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID: ${p.id}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("User ID: ${p.userId}"),
                    const SizedBox(height: 20),
                    Text(p.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(p.body),
                  ],
                ),
              );
            }

            if (state is ProfileError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            return const Center(child: Text("No data"));
          },
        ),
      ),
    );
  }
}


// YOUR ORIGINAL APP (Registration + UserInfo)


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController =_
