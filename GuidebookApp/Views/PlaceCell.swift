//
//  PlaceCell.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    // Properties
    var place:Place?

    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func showPlace(_ p:Place) {
        
        place = p
        
        // Set the label for the name of the place
        nameLabel.text = p.name
        
    }
    
}
