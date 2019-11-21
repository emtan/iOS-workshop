//
//  MyTableViewCell.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/20/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import UIKit
import Foundation

class MyTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
