// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Extension methods to fill some gaps in the default Dart FFI implementation
// of Utf16

import 'dart:ffi';

import 'package:ffi/ffi.dart';

extension Utf16Struct on Struct {
  Pointer<Utf16> utf16At(int byteOffset) =>
      Pointer<Utf16>.fromAddress(addressOf.address + byteOffset);
}

extension Utf16Conversion on Pointer<Utf16> {
  void packString(int maxLength, String string) {
    final data = cast<Uint16>().asTypedList(maxLength);
    final source = string.codeUnits;
    var stringLength = source.length;
    if (stringLength >= maxLength) {
      stringLength = maxLength - 1;
    }
    for (var i = 0; i < stringLength; i++) {
      data[i] = source[i];
    }
    data[stringLength] = 0;
  }

  String unpackString(int maxLength) {
    final pathData = cast<Uint16>().asTypedList(maxLength);

    var stringLength = pathData.indexOf(0);
    if (stringLength == -1) {
      stringLength = maxLength;
    }

    return String.fromCharCodes(pathData, 0, stringLength);
  }

  // Assumes an array of null-terminated strings, with the final
  // element terminated with a second null.
  List<String> unpackStringArray(int maxLength) {
    final results = <String>[];
    final buf = StringBuffer();
    final ptr = Pointer<Uint16>.fromAddress(address);

    for (var v = 0; v < maxLength; v++) {
      final charCode = ptr.elementAt(v).value;
      if (charCode != 0) {
        buf.writeCharCode(charCode);
      } else {
        results.add(buf.toString());
        if (ptr.elementAt(v + 1).value == 0) {
          break;
        } else {
          buf.clear();
        }
      }
    }

    return results;
  }
}
