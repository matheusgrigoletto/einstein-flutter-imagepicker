import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:galeria_imagens/models/Photo.dart';
import 'package:galeria_imagens/providers/PhotosProvider.dart';

class PhotoFormView extends StatefulWidget {
  @override
  _PhotoFormView createState() => _PhotoFormView();
}

class _PhotoFormView extends State<PhotoFormView> {
  final _form = GlobalKey<FormState>();
  Uint8List _image;
  final picker = ImagePicker();
  final Map<String, dynamic> _formData = {};

  String title = "Adicionar foto";

  void _loadFormData(Photo photo) {
    if (photo != null) {
      _formData['id'] = photo.id;
      _formData['name'] = photo.name;
      if (photo.photo != null) {
        setState(() {
          _image = photo.photo;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Photo _photo = ModalRoute.of(context).settings.arguments as Photo;
    _loadFormData(_photo);

    if (_photo != null) {
      this.title = "Editar foto";
    }
  }

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);

    if (pickedFile != null) {
      setState(() {
        var _file = File(pickedFile.path);
        _image = _file.readAsBytesSync();
      });
    }
  }

  void showMessage(BuildContext context, String message) {
    showDialog(context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                height: 160.0,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(message,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var _imagePreview =  _image == null
        ? Center(child: Text("Nenhuma foto selecionada"))
        : Image.memory(_image, width: 240.0, height: 240.0, fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 240.0,
                      child: _imagePreview,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text("Foto"),
                    Spacer(),
                    FlatButton.icon(
                      icon: const Icon(Icons.account_box),
                      label: const Text('Galeria'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                    ),
                    Spacer(),
                    FlatButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Câmera'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Legenda'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatório';
                    }

                    if (value.trim().length < 3) {
                      return 'Mínimo de 3 caracteres';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value,
                ),
                Spacer(),
                RaisedButton(
                  padding: const EdgeInsets.only(top: 12.0, right: 36.0, bottom: 12.0, left: 36.0),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: () {
                    final isValid = _form.currentState.validate();

                    if (isValid && _image != null) {
                      _form.currentState.save();

                      Provider.of<PhotosProvider>(context, listen: false).save(
                        Photo(
                          id: _formData['id'],
                          name: _formData['name'],
                          photo: _image,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      showMessage(context, "Foto e legenda são campos obrigatórios.");
                    }
                  },
                ),
                SizedBox(height: 10),
                FlatButton(
                  child: const Text('Cancelar'),
                  color: Colors.white,
                  textColor: Colors.purple,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]
          ),
        ),
      ),
    );
  }
}
