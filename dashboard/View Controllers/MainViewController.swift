//
//  MainViewController.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addReviewButton: UIButton!
    
    // MARK: - Variables
    var doctor: Doctor! {
        didSet {
            setNavbarTitle()
        }
    }
    var doctors: [Doctor]!
    var reviews = [Review]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        omitNavBackButtonTitle()
        configureTransparentNavigationBar()
        initData()
        subviewSettings()
        
        tableView.register(
            UINib(nibName: "PieChartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PieChartCell")
        tableView.register(
            UINib(nibName: "BarChartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "BarChartCell")
        tableView.register(
            UINib(nibName: "HeaderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HeaderCell")
        tableView.register(
            UINib(nibName: "ReviewTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ReviewCell")
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 42.0, right: 0.0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addReviewButton.setCardView(
            cornerRadius: 10.0,
            shadowSizeOffset: CGSize(width: 0, height: 1),
            shadowOpacity: 0.5,
            shadowRadius: 5.0,
            shadowColor: .ntGray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reviews = Data.shared.getReviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        reviews.removeAll()
    }
    
    // MARK: - IBAction
    @IBAction func addReviewTouchUpInside(_ sender: Any) {
        let viewController = storyboard?
            .instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Functions
    fileprivate func initData() {
        Data.shared.initData()
        doctor = Data.shared.getDoctor()
        doctors = Data.shared.getDoctors()
        reviews = Data.shared.getReviews()
    }
    
    private func subviewSettings() {
        addReviewButton.setTitle(Localization.get("main.button.add_review"), for: .normal)
        addReviewButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        addReviewButton.backgroundColor = .ntBlue
    }
    
    private func setNavbarTitle() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: setNavbarLeftTitle(title: doctor.name))
    }
}

// MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return reviews.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createOverallRatingSection(tableView, cellForRowAt: indexPath)
        case 1:
            return createRatingComparisonSection(tableView, cellForRowAt: indexPath)
        case 2:
            return createHeaderSection(tableView, cellForRowAt: indexPath)
        case 3:
            return createReviewSection(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func createOverallRatingSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PieChartCell", for: indexPath) as! PieChartTableViewCell
        
        cell.ratings = self.reviews.map({$0.rating})
        cell.selectionStyle = .none
        
        return cell
    }
    
    func createRatingComparisonSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BarChartCell", for: indexPath) as! BarChartTableViewCell
        
        cell.doctors = self.doctors
        cell.selectionStyle = .none
        
        return cell
    }
    
    func createHeaderSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableViewCell
        
        cell.headerLabel.text =
            Localization.get("main.label.patient_review") + (reviews.isEmpty ? "" : " (\(reviews.count))")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func createReviewSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        
        cell.review = self.reviews[indexPath.item]
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
