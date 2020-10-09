import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class Photo {
  final int id;
  final String name;
  final Uint8List photo;

  const Photo({
    this.id,
    @required this.name,
    @required this.photo,
  });
}