//
//  TableViewCell.swift
//  WeatherCityApp
//
//  Created by maria on 11/7/19.
//  Copyright © 2019 maria. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
