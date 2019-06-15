//
//  Area.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import Foundation
struct Area: Codable {
    var id: Int?
    var areaName: String?
   
        enum CodingKeys: String, CodingKey {
            case areaName = "area_name"
           
        }
}
