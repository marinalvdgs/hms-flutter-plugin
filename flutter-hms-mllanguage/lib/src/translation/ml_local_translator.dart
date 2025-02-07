/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0
        
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:async';

import 'package:flutter/services.dart';

import '../common/common.dart';
import '../common/model_download_strategy.dart';
import '../translation/ml_translate_setting.dart';

class MLLocalTranslator {
  late MethodChannel _c;

  LanguageDownloadListener? _listener;

  MLLocalTranslator() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    final channel = MethodChannel('hms_lang_local_translator');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void setDownloadListener(LanguageDownloadListener listener) {
    _listener = listener;
  }

  Future<bool> prepareModel(MLTranslateSetting? setting,
      LanguageModelDownloadStrategy? strategy) async {
    return await _c.invokeMethod("prepareModel", {
      "setting": setting?.toMap() ?? MLTranslateSetting.local().toMap(),
      "strategy": strategy?.toMap() ?? LanguageModelDownloadStrategy().toMap()
    });
  }

  Future<String?> asyncTranslate(String text) async {
    return await _c.invokeMethod('asyncTranslate', {'sourceText': text});
  }

  Future<String?> syncTranslate(String text) async {
    return await _c.invokeMethod('syncTranslate', {'sourceText': text});
  }

  /// Deletes a specific model associated with [langCode].
  Future<bool> deleteModel(String langCode) async {
    return await _c.invokeMethod("deleteModel", {'langCode': langCode});
  }

  Future<bool> stop() async {
    return await _c.invokeMethod('stop');
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final int all = call.arguments['all'];
    final int downloaded = call.arguments['downloaded'];

    _listener?.call(all: all, downloaded: downloaded);

    return Future<dynamic>.value(null);
  }
}
