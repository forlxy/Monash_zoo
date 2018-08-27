//
//  ListTableViewCell.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/27.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listDiscription: UILabel!
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
