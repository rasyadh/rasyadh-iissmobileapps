//
//  BarChartTableViewCell.swift
//  dashboard
//
//  Created by Twiscode on 15/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import Charts

class BarChartTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    
    // MARK: - Variable
    var doctors: [Doctor]! {
        didSet {
            guard let doctors = doctors else { return }
            
            titleLabel.text = Localization.get("main.label.rating_comparison")
            barChartUpdate(doctors)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setCardView(
            cornerRadius: 10.0,
            shadowSizeOffset: CGSize(width: 0, height: 1),
            shadowOpacity: 0.3,
            shadowRadius: 5.0,
            shadowColor: UIColor.gray)
        titleLabel.text = Localization.get("main.label.rating_comparison")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.setCardView(
            cornerRadius: 10.0,
            shadowSizeOffset: CGSize(width: 0, height: 1),
            shadowOpacity: 0.3,
            shadowRadius: 3.0,
            shadowColor: UIColor.gray)
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func barChartUpdate(_ doctors: [Doctor]) {
        let entries = doctors.map({ BarChartDataEntry(x: Double($0.id - 1), y: Double($0.rating)) })
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = nil
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = false
        dataSet.colors = [UIColor.ntPurple, UIColor.ntRed, UIColor.ntYellow]
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.legend.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: doctors.map { $0.name })
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawZeroLineEnabled = true
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.data = data
        
        barChartView.notifyDataSetChanged()
    }
}
