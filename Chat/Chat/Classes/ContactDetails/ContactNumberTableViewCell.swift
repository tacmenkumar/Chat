//
//  ContactTableViewCell.swift
//  Chat
//
//  Created by Niraj Kumar on 4/27/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit

class ContactNumberTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblContactNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
