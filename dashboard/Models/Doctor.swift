//
//  Doctor.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import Foundation

class Doctor: Codable {
    var id: Int = 0
    var name: String = ""
    var rating: Int = 0
    
    init(id: Int, name: String, rating: Int = 0) {
        self.id = id
        self.name = name
        self.rating = rating
    }
}
