# HomeTask
home task for tier App

using swift 4.0
xcode 9.2

1.clone the project

2.pod install

3.run the project

3.3 wait until map appears

4. choose debug->location->Apple

5. choose debug->location->none

you can check unit test from HomeTaskTest folder

for running test on your terminal use command below

xcodebuild clean build test -workspace "HomeTask.xcworkspace" -scheme "HomeTask" -destination "platform=iOS Simulator,name=iPhone 7,OS=11.2" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO

make sure you are in project directory
