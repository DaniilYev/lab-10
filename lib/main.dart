// main.dart — Single‑file version of the project

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

//---------------------------------------------
// LOGIN BLOC
//---------------------------------------------

class LoginState {
  final bool loading;
  final bool success;
  LoginState({this.loading = false, this.success = false});
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login(String email, String pass) async {
    emit(LoginState(loading: true));
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && pass.isNotEmpty) {
      emit(LoginState(success: true));
    } else {
      emit(LoginState(loading: false));
    }
  }
}

//---------------------------------------------
// LOGIN PAGE
//---------------------------------------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.success) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(controller: emailC, decoration: const InputDecoration(labelText: "Email")),
                  TextField(controller: passC, decoration: const InputDecoration(labelText: "Password")),
                  const SizedBox(height: 20),
                  state.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<LoginCubit>().login(emailC.text, passC.text);
                          },
                          child: const Text("Login"),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//---------------------------------------------
// HOME WITH TABS
//---------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Final Project"),
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(text: "News"),
            Tab(text: "Post"),
            Tab(text: "Anim"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          NewsPage(),
          PostPage(),
          AnimationPage(),
        ],
      ),
    );
  }
}

//---------------------------------------------
// NEWS PAGE (JSONPLACEHOLDER)
//---------------------------------------------

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<List<dynamic>> fetchNews() async {
    final res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNews(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data as List;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (c, i) => ListTile(
            title: Text(data[i]["title"]),
            subtitle: Text(data[i]["body"]),
          ),
        );
      },
    );
  }
}

//---------------------------------------------
// POST PAGE (SINGLE POST)
//---------------------------------------------

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  Future<Map<String, dynamic>> fetchPost() async {
    final res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final post = snapshot.data as Map;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post["title"], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(post["body"]),
            ],
          ),
        );
      },
    );
  }
}

//---------------------------------------------
// ANIMATION PAGE
//---------------------------------------------

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> anim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    anim = Tween(begin: 50.0, end: 200.0).animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) => Container(
          width: anim.value,
          height: anim.value,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
