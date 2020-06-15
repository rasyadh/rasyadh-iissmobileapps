//
//  PieChartTableViewCell.swift
//  dashboard
//
//  Created by Twiscode on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import Charts

class PieChartTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var oneStarView: UIView!
    @IBOutlet weak var twoStarView: UIView!
    @IBOutlet weak var threeStarView: UIView!
    
    // MARK: - Variable
    var ratings: [Int]! {
        didSet {
            guard let ratings = ratings else { return }
            
            if !ratings.isEmpty {
                let total = ratings.reduce(0, +)
                titleLabel.text = Localization.get("main.label.overall_rating") + " (\(total / ratings.count)/3)"
                pieChartUpdate(
                    ratings.filter({$0 == 1}),
                    ratings.filter({$0 == 2}),
                    ratings.filter({$0 == 3})
                )
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = Localization.get("main.label.overall_rating")
        [oneStarView, twoStarView, threeStarView].forEach { view in
            view?.setRoundedCorner(isCircular: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.setCardView(
            cornerRadius: 10.0,
            shadowSizeOffset: CGSize(width: 0, height: 1),
            shadowOpacity: 0.3,
            shadowRadius: 5.0,
            shadowColor: UIColor.gray)
        self.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func pieChartUpdate(_ oneStar: [Int], _ twoStar: [Int], _ threeStar: [Int]) {
        let entry1 = PieChartDataEntry(value: Double(oneStar.count))
        let entry2 = PieChartDataEntry(value: Double(twoStar.count))
        let entry3 = PieChartDataEntry(value: Double(threeStar.count))
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3])
        dataSet.label = nil
        dataSet.xValuePosition = .outsideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.valueLineWidth = .zero
        dataSet.selectionShift = .zero
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor.ntRed, UIColor.ntYellow, UIColor.ntPurple]
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.drawHoleEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.legend.enabled = false
        pieChartView.data = data
        
        pieChartView.notifyDataSetChanged()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
}
