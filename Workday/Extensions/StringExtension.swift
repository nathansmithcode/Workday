//
//  StringExtension.swift
//  Workday
//
//  Created by Nathan Smith on 12/9/22.
//

import Foundation

extension String {
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let dateFormatted = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            return dateFormatter.string(from: dateFormatted)
        }
        return ""
    }
}
