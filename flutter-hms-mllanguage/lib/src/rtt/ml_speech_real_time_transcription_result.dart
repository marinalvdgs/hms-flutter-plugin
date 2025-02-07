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

class MLSpeechRealTimeTranscriptionResult {
  String? result;
  List<RttOffset>? sentenceOffset;
  String? event;
  List<RttOffset>? wordOffset;

  MLSpeechRealTimeTranscriptionResult({
    this.result,
    this.sentenceOffset,
    this.event,
    this.wordOffset,
  });

  factory MLSpeechRealTimeTranscriptionResult.fromMap(
      Map<dynamic, dynamic> json) {
    var words = List<RttOffset>.empty(growable: true);
    var sentences = List<RttOffset>.empty(growable: true);

    if (json['sentenceOffset'] != null) {
      json['sentenceOffset'].forEach((v) {
        sentences.add(new RttOffset.fromMap(v));
      });
    }

    if (json['wordOffset'] != null) {
      json['wordOffset'].forEach((v) {
        words.add(new RttOffset.fromMap(v));
      });
    }

    return MLSpeechRealTimeTranscriptionResult(
      result: json['result'],
      event: json['event'],
      wordOffset: words,
      sentenceOffset: sentences,
    );
  }
}

class RttOffset {
  String? startTime;
  String? endTime;
  String? text;

  RttOffset({
    this.startTime,
    this.endTime,
    this.text,
  });

  factory RttOffset.fromMap(Map<dynamic, dynamic> json) {
    return RttOffset(
      startTime: json['startTime'],
      endTime: json['endTime'],
      text: json['text'],
    );
  }
}
