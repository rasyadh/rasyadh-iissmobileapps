//
//  Alert.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class Alert {
    static func displayAlert(title: String, message: String, sender: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localization.get("alertify.ok"), style: .default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func customConfirmation(title: String, message: String, confirmTitle: String, cancelTitle: String, sender: UIViewController, isDestructive: Bool = false, confirmCallback: (() -> Void)? = nil, cancelCallback: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message
            , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { action in
            if cancelCallback != nil {
                cancelCallback!()
            }
        }))
        if isDestructive {
            alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { action in
                if confirmCallback != nil {
                    confirmCallback!()
                }
            }))
        } else {
            alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { action in
                if confirmCallback != nil {
                    confirmCallback!()
                }
            }))
        }
        sender.present(alert, animated: true, completion: nil)
    }
}
