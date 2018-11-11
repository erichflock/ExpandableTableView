//
//  SectionInRowTableViewCell.swift
//  ExpandableTableView
//
//  Created by Erich Flock on 01.11.18.
//  Copyright © 2018 flock. All rights reserved.
//

import UIKit

class SectionInRowTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
