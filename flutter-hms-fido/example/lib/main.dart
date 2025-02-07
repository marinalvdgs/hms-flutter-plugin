/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';
import 'package:huawei_fido_example/bioauthn/face_manager_example.dart';
import './bioauthn/bio_authn_manager_example.dart';
import './bioauthn/bio_authn_prompt_example.dart';
import './fidoclient/fido_example.dart';
import './widgets/custom_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("HUAWEI FIDO EXAMPLE")),
        body: Column(
          children: [
            customButton("BIOAUTHN MANAGER EXAMPLE", () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BioAuthnManagerExample()));
            }),
            customButton("BIOAUTHN PROMPT EXAMPLE", () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BioAuthnPromptExample()));
            }),
            customButton("FACE MANAGER EXAMPLE", () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FaceManagerExample()));
            }),
            customButton("FIDO2CLIENT EXAMPLE", () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FidoExample()));
            }),
          ],
        ));
  }
}
