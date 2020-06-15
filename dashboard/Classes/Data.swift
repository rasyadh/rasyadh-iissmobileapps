//
//  Data.swift
//  dashboard
//
//  Created by Twiscode on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import Foundation

class Data: NSObject {
    static let shared = Data()
    
    private var doctor: Doctor!
    private var doctors: [Doctor]!
    private var reviews: [Review]! {
        didSet {
            doctors.forEach { doctor in
                var ratings: [Int] = []
                self.reviews.forEach { (review) in
                    if review.doctorId == doctor.id {
                        ratings.append(review.rating)
                    }
                }
                doctor.rating = ratings.reduce(0, +) / ratings.count
            }
        }
    }
    
    func initData() {
        doctors = [
            Doctor(id: 1, name: "Dr. Ardianto", rating: 0),
            Doctor(id: 2, name: "Dr. Susana", rating: 0),
            Doctor(id: 3, name: "Dr. Adji", rating: 0)
        ]
        doctor = doctors[0]
        reviews = [
            Review(doctorId: 1, name: "Freddie Wong", review: "Dr. Ardianto was professional and gracious. Problem was quickly diagnosed correctly and treatment options thoroughly explained.", rating: 3, createdAt: Date()),
            Review(doctorId: 2, name: "Jenny Matrix", review: "Listened patiently and carefully explained condition and treatment program.", rating: 2, createdAt: Date()),
            Review(doctorId: 3, name: "Brian D", review: "Wait too long.", rating: 1, createdAt: Date()),
            Review(doctorId: 1, name: "Ted Wong", review: "Quite expensive.", rating: 1, createdAt: Date()),
            Review(doctorId: 2, name: "Ki Swan", review: "Nice treatment program.", rating: 2, createdAt: Date()),
            Review(doctorId: 3, name: "Calhoun", review: "Great diagnostic.", rating: 3, createdAt: Date()),
            Review(doctorId: 1, name: "Ashley Barnstormer", review: "Carefully explained condition.", rating: 3, createdAt: Date()),
            Review(doctorId: 2, name: "Wendell", review: "Professional doctor.", rating: 2, createdAt: Date()),
            Review(doctorId: 3, name: "Mary Matrix", review: "Unprofessional.", rating: 1, createdAt: Date()),
            Review(doctorId: 1, name: "Shane Barnstormer", review: "Great services and condition.", rating: 3, createdAt: Date())
        ]
    }
    
    func getDoctor() -> Doctor {
        return doctor
    }
    
    func getDoctors() -> [Doctor] {
        return doctors
    }
    
    func getReviews() -> [Review] {
        return reviews
    }
    
    func addReview(_ review: Review) {
        reviews.append(review)
    }
}
