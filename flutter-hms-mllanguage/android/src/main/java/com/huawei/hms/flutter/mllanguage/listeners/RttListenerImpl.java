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

package com.huawei.hms.flutter.mllanguage.listeners;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;

import com.huawei.hms.flutter.mllanguage.utils.HMSLogger;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionConstants;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionListener;
import com.huawei.hms.mlsdk.speechrtt.MLSpeechRealTimeTranscriptionResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class RttListenerImpl implements MLSpeechRealTimeTranscriptionListener {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Activity activity;
    private final MethodChannel channel;

    public RttListenerImpl(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onRecognizingResults(Bundle partials) {
        Map<String, Object> m1 = new HashMap<>();
        m1.put("event", "onRecognizingResults");
        if (partials != null) {
            boolean isFinal = partials.getBoolean(MLSpeechRealTimeTranscriptionConstants.RESULTS_PARTIALFINAL);
            if (isFinal) {
                ArrayList<MLSpeechRealTimeTranscriptionResult> wordOffset =
                        partials.getParcelableArrayList(MLSpeechRealTimeTranscriptionConstants.RESULTS_WORD_OFFSET);
                ArrayList<MLSpeechRealTimeTranscriptionResult> sentenceOffset =
                        partials.getParcelableArrayList(MLSpeechRealTimeTranscriptionConstants.RESULTS_SENTENCE_OFFSET);

                if (wordOffset != null) {
                    m1.put("wordOffset", segmentsToMap(wordOffset));
                }

                if (sentenceOffset != null) {
                    m1.put("sentenceOffset", segmentsToMap(sentenceOffset));
                }
            }
            m1.put("result", partials.getString(MLSpeechRealTimeTranscriptionConstants.RESULTS_RECOGNIZING));
            invoke(m1);
        }
    }

    @Override
    public void onError(int i, String s) {
        Map<String, Object> m2 = new HashMap<>();
        m2.put("event", "onError");
        m2.put("errCode", i);
        m2.put("errMsg", s);
        invoke(m2);
    }

    @Override
    public void onStartListening() {
        Map<String, Object> m3 = new HashMap<>();
        m3.put("event", "onStartListening");
        invoke(m3);
    }

    @Override
    public void onStartingOfSpeech() {
        Map<String, Object> m4 = new HashMap<>();
        m4.put("event", "onStartingOfSpeech");
        invoke(m4);
    }

    @Override
    public void onVoiceDataReceived(byte[] bytes, float v, Bundle bundle) {
        Map<String, Object> m5 = new HashMap<>();
        m5.put("event", "onVoiceDataReceived");
        m5.put("bytes", bytes);
        m5.put("energy", v);
        invoke(m5);
    }

    @Override
    public void onState(int i, Bundle bundle) {
        Map<String, Object> m6 = new HashMap<>();
        m6.put("event", "onState");
        m6.put("state", i);
        invoke(m6);
    }

    private void invoke(Map<String, Object> map) {
        if (map.get("event").equals("onError")) {
            HMSLogger.getInstance(activity).sendPeriodicEvent("aftEvent", String.valueOf(map.get("errorCode")));
        } else {
            HMSLogger.getInstance(activity).sendPeriodicEvent("aftEvent");
        }
        handler.post(() -> channel.invokeMethod("rttEvent", map));
    }


    private List<Map<String, Object>> segmentsToMap(ArrayList<MLSpeechRealTimeTranscriptionResult> segments) {
        ArrayList<Map<String, Object>> segList = new ArrayList<>();

        for (int i = 0; i < segments.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLSpeechRealTimeTranscriptionResult res = segments.get(i);
            map.put("endTime", res.endTime);
            map.put("startTime", res.startTime);
            map.put("text", res.text);
            segList.add(map);
        }
        return segList;
    }
}
