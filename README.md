<img src="https://img.shields.io/github/issues/M0TRIX/HomeTask"> <img src="https://img.shields.io/github/forks/M0TRIX/HomeTask"> <img src="https://img.shields.io/github/stars/M0TRIX/HomeTask"> <img src="https://img.shields.io/github/license/M0TRIX/HomeTask">

# HomeTask
home task for tier App

> using swift 4.0
> xcode 9.2
> MVVM

1.clone the project

2. ``` pod install ```

3.run the project
> wait until map appears

4. choose debug->location->Apple

5. choose debug->location->none

<img src="https://github.com/M0TRIX/HomeTask/blob/master/shot.png">

you can check unit test from HomeTaskTest folder

for running test on your terminal use command below

> xcodebuild clean build test -workspace "HomeTask.xcworkspace" -scheme "HomeTask" -destination "platform=iOS Simulator,name=iPhone 7,OS=11.2" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO

make sure you are in project directory


# Licence

Copyright [2022] Ali Asadi

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
