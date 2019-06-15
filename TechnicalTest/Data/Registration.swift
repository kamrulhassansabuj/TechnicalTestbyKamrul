//
//  Registration.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import Foundation
// MARK: - Login
struct Registration: Codable {
    let email, mobile: String
    let fullName,pinCode: String
    
    enum CodingKeys: String, CodingKey {
        case email, mobile
        case fullName = "full_name"
        case pinCode = "pin_code"
    }
}
