//
//  ResultsTableCell.swift
//  Yelp
//
//  Created by Tuze on 4/7/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit

class ResultsTableCell: UITableViewCell {

    @IBOutlet weak var restaurantType: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var FarAway: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    
  
    var resturant: Restaurant? {
        didSet {
            restaurantImage.layer.cornerRadius = 10
            restaurantImage.layer.masksToBounds = true
            
            if let name = resturant?.restaurantName {
                restaurantName.text = name
            }
            
            if let address = resturant?.restaurantAddress {
                restaurantAddress.text = address
            }
            
            if let type = resturant?.restaurantType {
                restaurantType.text = type
            }
            
        }
    }

}
