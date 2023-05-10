import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_http/model/datum_model.dart';
import 'package:flutter_http/service/api_service.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService _apiService = ApiService();
  List<DatumModel> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _apiService.getUserMethod().then((value) {
      setState(() {
        if (value != null && value.data != null) {
          users = value.data;
          isLoading = false;
        } else {
          isLoading = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].firstName),
                    subtitle: Text(users[index].email),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(users[index].avatar),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
