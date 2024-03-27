//
//  Model.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import Foundation

struct Person: Codable, Hashable {
    var id: Int?
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String?
    
    static var example = Person(email: "michael.lawson@reqres.in",first_name: "Michael", last_name: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg")
    
    init() {
        email = ""
        first_name = ""
        last_name = ""
        self.avatar = nil
    }
    
    init(email: String, first_name: String, last_name: String, avatar: String? = nil) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.avatar = avatar
    }
    
    mutating func clearData() {
        self.email = ""
        self.first_name = ""
        self.last_name = ""
        self.avatar = nil
    }
}
