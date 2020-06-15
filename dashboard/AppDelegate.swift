//
//  AppDelegate.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set UI Style Theme
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        // Config App & Environment
        configureThirdPartyServices(application, launchOptions)
        configureAppEnvironment()
        
        return true
    }
    
    // MARK: - Configure
    private func configureThirdPartyServices(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?) {
        // IQKeyboardManager Setup
        IQKeyboardManager.shared.enable = true
    }
    
    private func configureAppEnvironment() {
        let localeLanguage = String(Locale.preferredLanguages.first!.prefix(2))
        switch localeLanguage {
        case LanguageName.english.rawValue:
            Localization.shared.setLanguage(.english)
        default:
            Localization.shared.setLanguage(.english)
        }
    }
}

