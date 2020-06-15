//
//  ReviewTableViewCell.swift
//  dashboard
//
//  Created by Twiscode on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    // MARK: - Variable
    var review: Review! {
        didSet {
            guard let review = review else { return }
            
            nameLabel.text = review.name
            dateLabel.text = review.createdAt.toString(format: "dd MMMM yyyy")
            reviewLabel.text = review.review
            ratingView.rating = Double(review.rating)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setRoundedCorner(cornerRadius: 10.0)
        containerView.setBorderView(color: UIColor.ntGray.cgColor)
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        nameLabel.textColor = .ntTitle
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        dateLabel.textColor = .ntSubtitle
        reviewLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        reviewLabel.textColor = .ntTitle
        ratingView.settings.updateOnTouch = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        dateLabel.text = ""
        reviewLabel.text = ""
        ratingView.rating = 0
    }
}
