# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## [v1.1.18] - 2021-09-10

### Added
- Support Selfie config to skip the start/biometrics consent screen

### Changed
- Attempting to start an Inquiry on templates prefixed with `itmpl_` or `itmplv_` will now fail immediately.

### Fixed
- No longer show back button on government id capture screen when selection screen is skipped because of one ID type.

## [v1.1.17] - 2021-08-26
### Added
- Added theme option to hide button images
- Made selfie instruction strings overrideable 
- Applied camera instruction text styling to selfie instruction title
- Centered verification processing animation if no strings provided 

## [v1.1.16] - 2021-08-18
### Added
- Added support for Keypass ID government id type.

## [v1.1.15] - 2021-08-11
### Added
- Added the following public strings for database start screen: `databaseStartTitle`, `databaseStartBody`, and `databaseStartButton`.
- Added themeable text alignment on title and body labels: 'titleTextAlignment' and 'bodyTextAlignment'
- The theme asset, `verificationFailedAsset`, is now used on selfie failure in addition to gov id failure

## [v1.1.14] - 2021-07-28
### Added
- Added support for visa government id type.

## [v1.1.13] - 2021-07-20
### Added
- Added support for custom Selfie animation on selfie start view

## [v1.1.12] - 2021-07-09
### Added
- Added Government ID combined step for Inquiry 3.0 Flow
- Added Selfie combined step for Inquiry 3.0 Flow
- Enabled skipping Government ID select screen when only one ID class option is present

### Fixed
- Fixed icon tinting on buttons. This is now themeable via `buttonImageTintColor`.
- Added support for theming processing government id animations.
- Added support for theming the selfie intro animation.

## [v1.1.11] - 2021-06-21
### Fixed
- Fixed a bug where the back button could be tinted incorrectly.

## [v1.1.10] - 2021-06-01
### Fixed
- Fixed a bug where a prefilled country code was not being set in certain cases.

## [v1.1.9] - 2021-05-26
### Fixed
- Fixed a bug where the back button image was not being tinted correctly when taking a photo of a government ID.
- Fixed a bug where the close button was not being displayed correctly when picking a country or US state.
- Fixed a bug where the shutter button could not work correctly when taking a photo of a government ID.
- Fixed a bug where the camera permissions dialog was not displaying the camera icon.

## [v1.1.8] - 2021-05-21
### Added
- Added strings for `countryListTitle`, `countryListSuggested` and `countryListAllCountries`.
- Added theme properties for `cancelButtonAlternateBackgroundColor` and `cancelButtonAlternateTextColor`.

### Changed
- `ImageAsset` can now specify its `Bundle`.
- `ImageAsset` can now be constructed with a `UIImage`.

### Fixed
- Fixed a bug  where the SDK's theme could be overridden by `UIAppearance`.

## [v1.1.7] - 2021-05-10
### Fixed
- Fixed a bug where prefilled data wasn't being read correctly. 

## [v1.1.6] - 2021-05-05
### Added
- Added more customization options by adding new theme properties and moved additional strings to `Persona.strings`. 

### Fixed
- Fixed a bug where database verifications that required further user input were being terminated early.

## [v1.1.5] - 2021-04-28
### Fixed
- Fixed a bug where clients could have symbols collisions if their app used one of our dependencies. These are now prefixed to avoid this. 
- Improved hinting for failed age comparison government ID verification

## [v1.1.4] - 2021-04-09
### Fixed
- Fixed a bug where failed verifications would sometimes not start the next verification.

## [v1.1.3] - 2021-03-31
### Fixed
- Fixed a visual bug where phone numbers with errors would not be displayed correctly.
- Fixed an occasional crashing bug when entering phone numbers.

## [v1.1.2] - 2021-03-24
### Added
-  Added a `cancelButtonTextColor` option to the theme.
- Added `buttonShadowColor`, `buttonShadowOffset` and `buttonShadowRadius` options to the theme to set shadows on buttons.
- Added `cancelButtonShadowColor`, `cancelButtonShadowOffset` and `cancelButtonShadowRadius` options to the theme to set shadows on cancel buttons.

### Fixed
- Fixed a visual bug where the selfie overlay animation could sometimes get stuck.
- Fixed SSN entry validation.
- Fixed a visual bug where the comments field was hidden behind the keyboard on shorter devices.
- Fixed a visual bug where the processing screen was not rendered correctly on 4.7" devices.

## [v1.1.1] - 2021-03-03
### Changed
- Renamed National ID to State ID

## [v1.1.0] - 2021-02-25
### Added
- Prefill Phone verification with phone number from the Inquiry
- Prefill Database verification with phone number, name, and address from the Inquiry
- Added phone number formatting.

### Changed
- Updated translations for pt-BR

## [v1.0.7] - 2021-01-30
### Changed
- Changed default date picker style

### Added
- Added support for hiding the privacy policy
- Added support for Swift Package Manager
- Added support for `barcode_pdf417` and `passport_signature`
- Added missing localizations for 🇯🇵 and 🇨🇳 

## [v1.0.6] - 2021-01-06
### Added
- Added support for custom translations for success and failure screens.

### Changed
- Added support for hiding the privacy policy via the disclaimer config.
- Removed the cancel button from completion screen.

## [v1.0.5] - 2021-01-04
### Added
- Return address subdivision abbreviation in Inquiry response

## [v1.0.4] - 2020-12-02
### Added
- Added more UI components:
  - submit button
  - complete button
  - persona branding footer

### Changed
- Updated the Selfie flow to closely resemble the web experience.
- Replaced the image with an animation on the Selfie intro view.

### Fixed
- Fixed a visual bug where the shutter button's countdown timer wasn't visible on iOS 11.
- Fixed a bug where the keyboard would sometimes not be present when entering an SMS confirmation code.

## [v1.0.3] - 2020-11-04
### Fixed
- Fixed a bug where selfie verifications would not complete because the `canceled` state was unknown
- Added handling for canceled verifications

### Added
- Added support for UI steps
- Added Postal ID as an ID type for the Philippines
- UI components for text, title
- UI components for local and remote images
- UI components for privacy policy

### Changed
- Updated pt-BR translations for Brazil

## [v1.0.2] - 2020-10-22
### Changed
- Improved UI when retrying the entry of an SMS confirmation code.
- Added localized names for countries and US states.
- Removed SVGKit and Lottie as public dependencies

## [v1.0.1] - 2020-10-13
### Fixed 
- Fixed a bug where the keyboard wouldn't appear when entering an SMS confirmation code after the app had been backgrounded.
- Fixed a bug where the using the suggestions bar above the keyboard would not allow the support from being submitted.
- Fixed a UI bug in the state list picker when using a custom theme.
- Fixed a UI bug where separators were not being modified when using a custom theme.
- Fixed a UI bug where a 4-digit SSN could not be submitted without dismissing the keyboard.

## [v1.0.0] - 2020-09-23
### Added
- Added support for database verifications.
- Added date of birth validation.
- Added translations for `ja` and `zh`.
- Accept access tokens for resuming Inquiries.
- Enabled prepopulating the Inquiry fields.

### Fixed
- Fixed a couple of UI bugs where elements would either render strangely or not appear when in dark mode.
- Fixed a bug where verifications would not fail as expected in Sandbox mode.
- Fixed a bug where access tokens passed in were not respected

### Removed
- Removed the country field from the address fields when performing a database verification.
- Removed phone number from public Attributes.


## [v0.12.4] - 2020-09-01
### Added
- Added support for showing/hiding the pictograph on the completed and failed screens.

## [v0.12.3] - 2020-09-01
### Added
- Added localization for `pt-BR` 🇧🇷.

## [v0.12.2] - 2020-09-01
### Fixed
- Fixed iOS 11 support.

### Changed
- Added support for updated phone verification.

## [v0.12.0] - 2020-08-13
### Changed
- Added support for document upload.

## [v0.11.1] - 2020-07-31
### Changed
- Greatly improved theming support. All images and animations can now also be tinted via theme properties.
- Other small bug fixes and performance improvements.

## [v0.11.0] - 2020-07-08
### Added
- Added filtering for better image quality during auto-capture.

### Changed
- No longer uploading base64 strings for images.

### Fixed
- Fixed a bug with misaligned rects of interest when analyzing the camera feed.

## [v0.10.2] - 2020-06-04
### Added
- Added localizations for `ar` and `it`.

### Fixed
- Fixed a bug where the incorrect country could be used for templates that do not include the country selection step.

## [v0.10.1] - 2020-06-04
### Added
- Added localization support for `de`, `es`, `fr`, `pl`, `pt` and `ru`.

### Changed
- Improved auto-capture experience.

## [v0.10.0] - 2020-05-14
### Added
- Added support for inquiry attributes and relationships.
- Added disclaimer text for facial biometric consent.
- Added overlay when taking photos of passports.
- Added new support ticket form for verification failures for clients that have this enabled.
- Added support for changing the government ID that is currently being photographed.

### Changed
- The list of countries that can be selected is now be configurable.
- Removed unused theme properties.

### Fixed
- Fixed a bug where some background colors did not respect the theme.
- Other small bug fixes and performance improvements.

## [v0.9.1] - 2020-04-15
### Changed
- You can now replace any title, body, or button text by providing your own strings. Read more about Customization here: https://sdk.withpersona.com/ios/docs/index.html

## [v0.9.0] - 2020-04-10
### Added
- Added support for manually turning the torch on/off.
- Added support for extracting barcode data.

### Changed
- Improved hinting at what may have gone wrong when taking selfies and photos of a government ID.
- UI changes to improve the overall experience.

## [v0.8.3] - 2020-04-02
### Added
- Added support for `note` field.

### Changed
- UI tweaks and bug fixes.
- Improved hints for failed ID scans.

## [v0.8.2] - 2020-03-20
### Fixed
- Fixed a bug where failed inquiries were not being handled correctly.

## [v0.8.1] - 2020-03-18
### Changed
- Testing ABI stability.

## [v0.8.0] - 2020-03-18
### Changed
- The `inquirySuccess` delegate method has changed to match `inquiryFailed` and the `Success` object has been replaced with `Attributes`.

### Fixed
- Fixes a UI issue when presenting the SDK UI from a navigation controller.
- Fixes UI issues on devices with 4" screens.

## [v0.7.1] - 2020-03-12
### Fixed
- `Success` properties are now public.
