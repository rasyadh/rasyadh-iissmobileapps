//
//  Review.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import Foundation

class Review: Codable {
    var doctorId: Int = 0
    var name: String = ""
    var review: String = ""
    var rating: Int = 0
    var createdAt: Date!
    
    init(doctorId: Int, name: String, review: String, rating: Int, createdAt: Date) {
        self.doctorId = doctorId
        self.name = name
        self.review = review
        self.rating = rating
        self.createdAt = createdAt
    }
}
