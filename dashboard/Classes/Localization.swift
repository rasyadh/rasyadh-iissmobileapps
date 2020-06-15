//
//  Localization.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

enum LanguageName: String {
    case english = "en"
}

class Localization {
    static let shared = Localization()
    private var languageBundle: Bundle!
    var languageIdentifier = ""
    
    func setLanguage(_ name: LanguageName) {
        let path = Bundle.main.path(forResource: name.rawValue, ofType: ".lproj")!
        let bundle = Bundle(path: path)!
        languageBundle = bundle
        
        switch name {
        case .english:
            languageIdentifier = "en"
        }
    }
    
    static func get(_ key: String) -> String {
        return NSLocalizedString(key, bundle: Localization.shared.languageBundle, comment: "")
    }
}
