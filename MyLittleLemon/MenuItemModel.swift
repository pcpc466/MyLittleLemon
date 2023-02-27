//
//  MenuItemModel.swift
//  MyLittleLemon
//
//  Created by Prashant Singh Chauhan on 2/18/23.
//

// https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json

import Foundation

struct menuList : Codable {
    let menu : [menuItem]
   
}

struct menuItem : Codable {
    let id : Int
    let title: String
    let price: String
    let image : String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
           case title = "title"
           case price = "price"
        case image = "image"
        case detail = "description"
       }
    }
