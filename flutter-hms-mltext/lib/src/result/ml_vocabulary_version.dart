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

class MlVocabularyVersion {
  String? dictionaryDimension;
  String? dictionarySize;
  String? versionNumber;

  MlVocabularyVersion(
      {this.dictionaryDimension, this.dictionarySize, this.versionNumber});

  MlVocabularyVersion.fromJson(Map<String, dynamic> map) {
    dictionaryDimension = map['dictionaryDimension'];
    dictionarySize = map['dictionarySize'];
    versionNumber = map['versionNumber'];
  }
}
