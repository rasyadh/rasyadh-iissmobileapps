//
//  StringExtensions.swift
//  dashboard
//
//  Created by Rasyadh Abdul Aziz on 13/06/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

extension String {
    func toDate(format: String = "") -> Date? {
        var stringDate = ""
        let dateFormatter = DateFormatter()
        
        if format == "" {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            stringDate = self
        } else if format == "yyyy-MM-dd HH:mm" {
            dateFormatter.dateFormat = format
            let index = self.index(self.startIndex, offsetBy: format.count)
            stringDate = String(self[..<index])
        } else if format == "yyyy-MM-dd'T'HH:mm:ss.SSSZ" {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            stringDate = self
        } else if format == "yyyy-MM-dd" {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            stringDate = self
        } else {
            dateFormatter.dateFormat = format
            stringDate = self
        }
        
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        if let date = dateFormatter.date(from: stringDate) {
            return date
        } else {
            return nil
        }
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func UTCToLocal(fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
