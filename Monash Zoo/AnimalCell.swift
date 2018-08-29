//
//  AnimalCell.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/28.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
