//
//  HeaderTableViewCell.swift
//  dashboard
//
//  Created by Twiscode on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
        headerLabel.textColor = .ntTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        headerLabel.text = ""
    }
}
