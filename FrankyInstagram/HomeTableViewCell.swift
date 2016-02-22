//
//  HomeTableViewCell.swift
//  FrankyInstagram
//
//  Created by Franky Liang on 2/21/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var homepostCaptionLabel: UILabel!

    @IBOutlet weak var homepostImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
