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

class MLLangDetectorSetting {
  String sourceText;
  double? trustedThreshold;
  bool? isRemote;

  factory MLLangDetectorSetting.create({
    required String sourceText,
    double? trustedThreshold,
    bool? isRemote,
  }) {
    return MLLangDetectorSetting._(
      sourceText: sourceText,
      trustedThreshold: trustedThreshold,
      isRemote: isRemote,
    );
  }

  MLLangDetectorSetting._({
    required this.sourceText,
    this.isRemote,
    this.trustedThreshold,
  });

  Map<String, dynamic> toMap() {
    return {
      "sourceText": sourceText,
      "trustedThreshold": trustedThreshold ?? 0.5,
      "isRemote": isRemote ?? true
    };
  }
}
