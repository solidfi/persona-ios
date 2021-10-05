# persona-ios
Persona Sample for iOS

Overview :
- Persona provides a powerful, secure platform to help organizations collect, verify, store, and analyze the identity of any individual.

Requirements :
- iOS 13 and above
- Xcode 12 and above

Configure Persona Sample :
- Clone respository
```groovy
git clone git@github.com:solidfi/persona-ios.git
OR
git clone https://github.com/solidfi/persona-ios.git
```
- Install CocoaPods
```groovy
1. Install CocoaPods at https://cocoapods.org/
2. In the `PersonaSample/` directory run `pod install`
```
- Open workspace and run in Simulator
```groovy
1. Launch `Xcode` and open the workspace `PersonaSample/PersonaSample.xcworkspace`
2. Run in Simulator
```
Locate your Template ID (other than from API):
- Sign up for a free Persona account which comes with Sandbox access
- Login to the Persona Dashboard and go to the Development section.
- Select the Template you want to use from the drop-down and copy the Template ID for later.

Required fields:
- Template ID : which you will get from Persona dashboard OR your server 
- Person ID : which you will get from your server 
- Inquiry ID : which you will get on Persona Inquiry create success

Reference links :
- Persona Integration : https://docs.withpersona.com/docs/ios-inquiry-sdk-integration-guide
- Solid API Integration : https://documenter.getpostman.com/view/13543869/TWDfEDwX#ce8c0e57-0dcf-45ea-87d8-6f03a302e027
