import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:galeria_imagens/providers/PhotosProvider.dart';
import 'package:galeria_imagens/routes/AppRoutes.dart';
import 'package:galeria_imagens/views/PhotoFormView.dart';
import 'package:galeria_imagens/views/PhotoListView.dart';

void main() {
  runApp(GaleriaApp());
}

class GaleriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PhotosProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Galeria de imagens',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => PhotoListView(),
          AppRoutes.FORM: (_) => PhotoFormView(),
        },
      ),
    );
  }
}

