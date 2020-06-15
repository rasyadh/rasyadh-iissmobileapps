//
//  DoctorPickerViewController.swift
//  dashboard
//
//  Created by Twiscode on 14/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class DoctorPickerViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var chooseDoctorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var delegate: DoctorPickerDelegate?
    var doctors: [Doctor] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        subviewSettings()
        
        tableView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - IBAction
    @IBAction func closeTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    private func initData() {
        doctors = Data.shared.getDoctors()
    }
    
    private func subviewSettings() {
        chooseDoctorLabel.text = Localization.get("doctor_picker.title")
        chooseDoctorLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        chooseDoctorLabel.textColor = .ntTitle2
    }
}

// MARK: - UITableView DataSource
extension DoctorPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath)
        
        cell.textLabel?.text = doctors[indexPath.item].name
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.ntLightBlue
        cell.selectedBackgroundView = bgColorView
        cell.selectionStyle = .blue
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension DoctorPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectDoctor(doctors[indexPath.item])
    }
}

// MARK: - Protocol
protocol DoctorPickerDelegate {
    func selectDoctor(_ doctor: Doctor)
}
