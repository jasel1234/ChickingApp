//
//  verticalCollectionViewCell.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit

class verticalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var food_image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var add_cart_button: UIButton!
     override func draw(_ rect: CGRect) { //Your code should go here.
                super.draw(rect)
        self.add_cart_button.layer.cornerRadius = 8
            }
}
