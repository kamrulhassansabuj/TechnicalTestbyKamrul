//
//  Login.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import Foundation
// MARK: - Login
struct Login: Codable {
    let validation: String
    let loginData: LoginData
    
    enum CodingKeys: String, CodingKey {
        case validation
        case loginData = "login_data"
    }
}

// MARK: - LoginData
struct LoginData: Codable {
    let mobile: String
    let accountExists: Bool
    let customer: Customer
    
    enum CodingKeys: String, CodingKey {
        case mobile
        case accountExists = "account_exists"
        case customer
    }
}

// MARK: - Customer
struct Customer: Codable {
    let id: Int
    let customerName, email, mobile: String
//    let gender, age: JSONNull?
    let isActive: Int
    let address, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case customerName = "customer_name"
        case email, mobile
        case isActive = "is_active"
        case address
        case createdAt = "created_at"
    }
}
