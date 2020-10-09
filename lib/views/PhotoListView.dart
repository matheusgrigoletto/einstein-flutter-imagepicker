import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:galeria_imagens/components/PhotoTile.dart';
import 'package:galeria_imagens/providers/PhotosProvider.dart';
import 'package:galeria_imagens/routes/AppRoutes.dart';

class PhotoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PhotosProvider photos = Provider.of<PhotosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria de imagens'),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(4),
                    itemCount: photos.count,
                    itemBuilder: (ctx, i) => PhotoTile(photos.byIndex(i)),
                    separatorBuilder: (BuildContext ctx, int index) => const Divider(),
                  ),
              ),
              SizedBox(height: 48),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.FORM);
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        tooltip: 'Adicionar foto',
        child: Icon(Icons.add),
      ),
    );
  }
}