//
//  Model.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import Foundation

struct Person: Codable, Hashable {
    var id: Int = 0
    var email: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var avatar: String = ""
    
    static var example = Person(id: 1, email: "michael.lawson@reqres.in",first_name: "Michael", last_name: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg")
}
