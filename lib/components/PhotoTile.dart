import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:galeria_imagens/models/Photo.dart';
import 'package:galeria_imagens/routes/AppRoutes.dart';
import 'package:galeria_imagens/providers/PhotosProvider.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;

  const PhotoTile(this.photo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.memory(
          this.photo.photo,
          width: 32.0,
          height: 32.0,
          fit: BoxFit.cover
      ),
      title: Text(this.photo.name),
      trailing: Container(
        width: 96,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.FORM,
                  arguments: this.photo,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey.shade500,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Remover foto'),
                    content: Text('Deseja realmente remover a foto?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<PhotosProvider>(context, listen: false).destroy(this.photo);
                  }
                });
              },
            ),
          ],
        )
      ),
    );
  }
}