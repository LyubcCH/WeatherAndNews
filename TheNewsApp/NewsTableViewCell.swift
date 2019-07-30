//
//  NewsTableViewCell.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/29/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var datePublishedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
