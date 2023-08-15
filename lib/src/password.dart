import 'package:crypto/crypto.dart';
import 'dart:math';
import 'dart:convert';

class Password {
  static String generate(int _passLength,
      bool _useNumbers,
      bool _useLetters,
      bool _useSymbols,
      bool _useCaps){
    String result='';
    var _random = Random();
    int _randomNumber = 0;

    for (int temp=_passLength ; temp>0; temp--) {
      if (_useNumbers) {
        _randomNumber = _random.nextInt(10);
        result = result + _randomNumber.toString();
        if (--_passLength==0) break;
      }
      if (_useLetters) {
        _randomNumber = _random.nextInt(26)+97;
        result = result + String.fromCharCode(_randomNumber);
        if (--_passLength==0) break;
      }
      if (_useSymbols) {
        switch (_random.nextInt(2)) {
          case 0:
            _randomNumber = _random.nextInt(15) + 33;
            break;
          case 1:
            _randomNumber = _random.nextInt(7) + 58;
            break;
        }
        result = result + String.fromCharCode(_randomNumber);
        if (--_passLength==0) break;
      }
      if (_useCaps) {
        _randomNumber = _random.nextInt(26)+65;
        result = result + String.fromCharCode(_randomNumber);
        if (--_passLength==0) break;
      }
    }
    return result;
  }

  static String getHash(String hashType, String str) {
    final bytes = utf8.encode(str); // конвертируем строку в байты
    Digest hash;
    var result = '';

    if (hashType == 'MD5') {
      hash = md5.convert(bytes);
      result = hash.toString();
    }
    if (hashType == 'SHA-1') {
      hash = sha1.convert(bytes);
      result = hash.toString();
    }
    if (hashType == 'SHA-256') {
      hash = sha256.convert(bytes);
      result = hash.toString();
    }
    if (hashType == 'SHA-512') {
      hash = sha512.convert(bytes);
      result = hash.toString();
    }

    return result;
  }

}
