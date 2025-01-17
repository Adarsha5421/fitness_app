import 'package:fitness_tracker/app/app.dart';
import 'package:fitness_tracker/app/di/di.dart';
import 'package:fitness_tracker/core/network/hiveservice.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialized the hive database
  await HiveService.init();
// Initialize the dependencies
  await initDependencies();
  runApp(
    const App(),
  );
}
