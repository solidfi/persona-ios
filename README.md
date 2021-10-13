# persona-ios

## Table of contents
- [Overview](#overview)
- [Version](#version)
- [Tooling](#tooling)
- [API Reference](#api-reference)
- [Dependencies](#dependencies)
- [Configure Persona Sample](#configure-persona-sample)
- [Getting started](#getting-started)
- [Install and run CocoaPods](#install-and-run-cocoapods)
- [Open workspace and run in Simulator](#open-workspace-and-run-in-simulator)



## Overview
Persona provides a powerful, secure platform to help organizations collect, verify, store, and analyze the identity of any individual.

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


## Version
iOS SDK v1.1.18

## Tooling
- iOS 13.0 +
- Xcode 11 +
- Swift 5.0 +
- CocoaPods

## API Reference
- Persona Integration : https://docs.withpersona.com/docs/ios-inquiry-sdk-integration-guide
- Solid API Integration : https://documenter.getpostman.com/view/13543869/TWDfEDwX#ce8c0e57-0dcf-45ea-87d8-6f03a302e027

## Dependencies
- PersonaInquirySDK

## Getting started

### 1. Required Keys:
In order to start building and running the Persona sample, you'll need certain configuration keys set up.

#### 1.1 Template ID (Required)
The Persona Inquiry verification flow is initiated with an InquiryConfiguration. This configuration can be initialized with a `templateId`. This key will be returned from the API call

#### 1.2 Reference ID (Required)
Along with TemplateID, InquiryConfiguration also require a unique ID which we will associate with the inquiry. The identifier can be used to monitor user progress in newly created inquiries. In this sample `PersonId` is will be passed as value for `referenceId` parameter.
InquiryConfiguration will start the Inquiry flow and takes control of the user interface. Once the flow completes the control of the user interface is returned to the app and the appropriate delegate method will be called.

#### 1.3 Inquiry Results 
The results of the inquiry are passed back to the InquiryDelegate, and are as follows

inquirySuccess — the inquiry passed
inquiryFailed — the inquiry failed
inquiryCancelled — the inquiry was cancelled by the user
inquiryError — the inquiry errored


