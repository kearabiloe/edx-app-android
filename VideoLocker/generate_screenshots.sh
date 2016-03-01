echo "Generating screenshots..."
echo "y" | android update sdk -a --no-ui --filter sys-img-armeabi-v7a-android-23,sys-img-x86_64-android-23
echo no | android create avd --force -n test -t android-23 --abi default/armeabi-v7a
emulator -avd test -no-skin -no-audio -no-window &
android-wait-for-emulator
adb shell input keyevent 82 &
./../gradlew assembleProdRelease
adb install -r build/outputs/apk/VideoLocker-prod-release.apk
AppPackage=org.edx.mobile
ScreenshotsDir=src/main/play/en-GB/listing/phoneScreenshots
adb shell am start -n $AppPackage/.view.LoginActivity -W
adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $ScreenshotsDir/LoginActivity.png
adb shell am force-stop $AppPackage
adb shell am start -n $AppPackage/.view.RegisterActivity -W
adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $ScreenshotsDir/RegisterActivity.png
adb shell am force-stop $AppPackage
adb shell am start -n $AppPackage/.view.SplashActivity -W
adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $ScreenshotsDir/SplashActivity.png
adb shell am force-stop $AppPackage
adb shell am start -n $AppPackage/.view.LaunchActivity -W
adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $ScreenshotsDir/LaunchActivity.png
adb shell am force-stop $AppPackage
adb shell am start -n $AppPackage/.view.MyCoursesListActivity -W
adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $ScreenshotsDir/MyCoursesListActivity.png
