//
//  foodOfferCollectionViewCell.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit

class foodOfferCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var food_image: UIImageView!
    @IBOutlet weak var food_price: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var food_description: UILabel!
    @IBOutlet weak var order_button: UIButton!
    override func draw(_ rect: CGRect) { //Your code should go here.
            super.draw(rect)
    self.order_button.layer.cornerRadius = 8
        }
}
