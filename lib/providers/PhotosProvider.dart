import 'package:flutter/material.dart';
import 'package:galeria_imagens/models/Photo.dart';

class PhotosProvider with ChangeNotifier {
  final Map<int, Photo> _items = {};

  int get count => _items.length;

  Photo byIndex(int index) => _items.values.elementAt(index);

  void _update(Photo photo) {
    _items.update(photo.id, (_) => photo);
  }

  int _generateId() {
    int id = 1;
    if (this.count > 0) {
      id = _items.values.last.id + 1;
    }
    return id;
  }

  void _create(Photo photo) {
    final int id = this._generateId();

    _items.putIfAbsent(id, () => Photo(
      id: id,
      name: photo.name,
      photo: photo.photo,
    ));
  }

  void save(Photo photo) {
    if (photo == null) {
      return;
    }

    if (photo.id != null && _items.containsKey(photo.id)) {
      this._update(photo);
    } else {
      this._create(photo);
    }

    notifyListeners();
  }

  void destroy(Photo photo) {
    if (photo != null && photo.id != null) {
      _items.remove(photo.id);
      notifyListeners();
    }
  }
}