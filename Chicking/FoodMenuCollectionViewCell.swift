//
//  FoodMenuCollectionViewCell.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit

class FoodMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var horizontal_list: UILabel!
    
    override func prepareForReuse() {
        backgroundColor = .clear
        super.prepareForReuse()
    }
}
