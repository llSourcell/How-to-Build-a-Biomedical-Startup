import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _speech_channel =
    const MethodChannel("bz.rxla.flutter/recognizer");

class SpeechRecognizer {
  static void setMethodCallHandler(handler) {
    _speech_channel.setMethodCallHandler(handler);
  }

  static Future activate() {
    return _speech_channel.invokeMethod("activate");
  }

  static Future start(String lang) {
    return _speech_channel.invokeMethod("start", lang);
  }

  static Future cancel() {
    return _speech_channel.invokeMethod("cancel");
  }

  static Future stop() {
    return _speech_channel.invokeMethod("stop");
  }
}
