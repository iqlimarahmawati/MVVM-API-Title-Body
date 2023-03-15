//
//  ImageModel.swift
//  MVVM Title Body
//
//  Created by Phincon on 15/03/23.
//

import Foundation
struct ImageModel : Codable {
    var albumId: Int
    var id: Int
    var title : String
    var thumbnailImage: String
    
    enum CodingKeys:String, CodingKey {
        case albumId
        case id
        case title
        case thumbnailImage = "thumbnailUrl"
    }
}
