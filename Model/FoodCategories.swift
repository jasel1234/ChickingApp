//
//  FoodCategories.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import Foundation
struct FoodCategory: Decodable {
    
    let data: [Data2]
}
struct Data2: Codable {
    let id: Int
    let title: String
}
struct  Selected_category: Decodable {
    let data: [SelectedCategory]
}
struct SelectedCategory: Codable {
    let title: String
    let image: String
    let description: String
    let price: String
}
