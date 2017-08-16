//
//  TrackingManager.swift
//  RunBuddy
//
//  Created by Kevin Lopez on 3/6/17.
//  Copyright © 2017 Kevin E Lopez. All rights reserved.
//

struct TrackingManager {

    static func trackEventWith(_ trackData: TrackData) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.send(trackData.dictionary)
    }

    static func trackButtonPressFor(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .uiAction, action: .buttonPress, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackSystemAlert(_ label: String, value: NSNumber) {
        let trackData = TrackData(event: .systemAlert, action: .alertPress, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackFieldTap(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .uiAction, action: .formFieldTap, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackErrorAlert(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .errorAlert, action: .confirmError, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackImageSelect(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .uiAction, action: .imageSelect, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackActionSheet(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .actionSheet, action: .buttonPress, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackSegmentControl(_ label: String) {
        let trackData = TrackData(event: .uiAction, action: .segmentControlPress, label: label)
        trackEventWith(trackData)
    }

    static func trackCollectionTap(_ label: String, value: NSNumber) {
        let trackData = TrackData(event: .uiAction, action: .collectionTap, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackRefresh(_ label: String) {
        let trackData = TrackData(event: .uiAction, action: .refresh, label: label)
        trackEventWith(trackData)
    }

    static func trackTabPress(_ label: String) {
        let trackData = TrackData(event: .uiAction, action: .tabPress, label: label)
        trackEventWith(trackData)
    }

    static func trackMapTap(_ label: String) {
        let trackData = TrackData(event: .uiAction, action: .mapLocationTap, label: label)
        trackEventWith(trackData)
    }

    static func trackNativeAlert(_ label: String, value: NSNumber? = nil) {
        let trackData = TrackData(event: .nativeAlert, action: .alertPress, label: label, value: value)
        trackEventWith(trackData)
    }

    static func trackPresentation(_ label: String) {
        let trackData = TrackData(event: .uiAction, action: .presentation, label: label)
        trackEventWith(trackData)
    }

    static func trackScreen(_ screen: AppScreen) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screen.txt)
        tracker?.send(GAIDictionaryBuilder.createScreenView().build() as? [AnyHashable: Any])
    }
}

enum EventCategory: String {
    case uiAction = "ui_action"
    case systemAlert = "system_alert"
    case errorAlert = "error_alert"
    case actionSheet = "action_sheet"
    case nativeAlert = "native_alert"

    var txt: String {
        return self.rawValue
    }
}

enum EventAction: String {
    case buttonPress = "button_press"
    case alertPress = "alert_press"
    case formFieldTap = "form_field_tap"
    case confirmError = "confirm_error"
    case imageSelect = "image_select"
    case segmentControlPress = "segment_control_press"
    case collectionTap = "collection_tap"
    case refresh = "refresh"
    case tabPress = "tab_press"
    case mapLocationTap = "map_location_tap"
    case presentation = "presentation"

    var txt: String {
        return self.rawValue
    }
}

enum AppScreen: String {
    case home = "Home"
    case locationPrimer = "LocationPrimer"
    case emailSignUp = "EmailSignUp"
    case login = "Login"
    case createProfile = "Create Profile"
    case runners = "Runners"
    case runDetails = "RunDetails"
    case profile = "Profile"
    case runs = "Runs"
    case inbox = "Inbox"
    case chat = "Chat"
    case account = "Account"
    case editProfile = "EditProfile"
    case settings = "Settings"
    case inviteToApp = "InviteToApp"
    case descriptionPlanRun = "DescriptionPlanRun"
    case locationPlanRun = "LocationPlanRun"
    case detailsPlanRun = "DetailsPlanRun"
    case inviteToRun = "InviteToRun"
    case inviteToRunsProfile = "InviteToRunsProfile"
    case forgotPassword = "ForgotPassword"

    var txt: String {
        return self.rawValue
    }
}
