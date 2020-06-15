//
//  FeedbackViewController.swift
//  dashboard
//
//  Created by Twiscode on 14/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import Cosmos
import FittedSheets

class FeedbackViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var doctorField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Variables
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        omitNavBackButtonTitle()
        configureTransparentNavigationBar()
        subviewSettings()
        
        doctorField.delegate = self
        doctorField.isEnabled = true
        doctorField.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(doctorFieldTouchUpInside(_:))))
    }
    
    // MARK: - Selector
    @objc private func doctorFieldTouchUpInside(_ sender: UITapGestureRecognizer) {
        let controller = storyboard?.instantiateViewController(
            withIdentifier: "DoctorPickerViewController") as! DoctorPickerViewController
        controller.delegate = self
        
        let sheetController = SheetViewController(
            controller: controller, sizes: [.fixed(260), .halfScreen, .fullScreen])
        sheetController.blurBottomSafeArea = false
        sheetController.adjustForBottomSafeArea = false
        sheetController.topCornersRadius = 10
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    // MARK: - IBAction
    @IBAction func submitTouchUpInside(_ sender: Any) {
        if validateField() {
            Data.shared.addReview(
                Review(doctorId: doctor.id,
                       name: "Rasyadh Abdul Aziz",
                       review: feedbackTextView.text,
                       rating: Int(ratingView.rating),
                       createdAt: Date())
            )
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Functions
    private func subviewSettings() {
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)
        titleLabel.textColor = .ntHeadline
        titleLabel.text = Localization.get("feedback.title")
        
        doctorLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        doctorLabel.textColor = .ntTitle
        doctorLabel.text = Localization.get("feedback.label.doctor_name")
        
        feedbackLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        feedbackLabel.textColor = .ntTitle
        feedbackLabel.text = Localization.get("feedback.label.feedback")
        
        rateLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        rateLabel.textColor = .ntTitle
        rateLabel.text = Localization.get("feedback.label.rate_experience")
        
        doctorField.setRoundedCorner(cornerRadius: 10.0)
        doctorField.setBorderView(color: UIColor.ntGray.cgColor)
        doctorField.setPadding(16.0)
        doctorField.font = UIFont(name: "HelveticaNeue", size: 16.0)
        doctorField.textColor = .ntTitle
        doctorField.attributedPlaceholder = NSAttributedString(
            string: Localization.get("feedback.placeholder.choose_doctor"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ntSubtitle])
        
        feedbackTextView.setRoundedCorner(cornerRadius: 10.0)
        feedbackTextView.setBorderView(color: UIColor.ntGray.cgColor)
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
        feedbackTextView.font = UIFont(name: "HelveticaNeue", size: 16.0)
        feedbackTextView.textColor = .ntTitle
        feedbackTextView.placeholderColor = .ntSubtitle
        feedbackTextView.placeholder = Localization.get("feedback.placeholder.write_feedback")
        
        submitButton.setTitle(Localization.get("feedback.button.submit"), for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        submitButton.backgroundColor = .ntBlue
        submitButton.setRoundedCorner(cornerRadius: 10.0)
    }
    
    private func validateField() -> Bool {
        var errors = [String]()
        
        if doctorField.text!.isEmpty {
            errors.append(Localization.get("field_validation.invalid.message.doctor_empty"))
        }
        
        if feedbackTextView.text!.isEmpty {
            errors.append(Localization.get("field_validation.invalid.message.feedback_empty"))
        }
        
        if Int(ratingView.rating) == 0 {
            errors.append(Localization.get("field_validation.invalid.message.rating_empty"))
        }
        
        if errors.isEmpty {
            return true
        } else {
            let message = errors.joined(separator: "\n")
            Alert.displayAlert(
                title: Localization.get("field_validation.invalid.title"),
                message: message,
                sender: self)
            
            return false
        }
    }
}

// MARK: - TextField Delegate
extension FeedbackViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// MARK: - DoctorPicker Delegate
extension FeedbackViewController: DoctorPickerDelegate {
    func selectDoctor(_ doctor: Doctor) {
        self.doctor = doctor
        doctorField.text = doctor.name
    }
}
