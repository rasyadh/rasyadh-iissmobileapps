//
//  UIViewControllerExtensions.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Navigation Bar
    func configureTransparentNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func hideNavigationBarShadow() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func showNavigationBarShadow() {
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    func omitNavBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func hideNavBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setNavbarLeftView(title: String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .ntHeadline
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        let contentView = UIView(frame:
            CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, 0), height: titleLabel.frame.size.height))
        contentView.addSubview(titleLabel)
        
        return contentView
    }
    
    func setNavbarLeftTitle(title: String) -> UIView {
        let label = UILabel()
        label.text = title
        label.backgroundColor = .clear
        label.textColor = .ntHeadline
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20.0)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func setBarImageView(imageName: String) -> UIBarButtonItem {
        let logo = UIImage(named: imageName)
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = logo
        logoImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return UIBarButtonItem(customView: logoImageView)
    }
    
    // MARK: - Dismiss Keyboard
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
