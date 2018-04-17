//
//  Date+RandomUser.swift
//  RandomUser
//
//  Created by San on 18.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    static func convertStringToDate(dateStr: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatterGet.date(from: dateStr)
    }
    
    static func convertDataToStringBOD(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDataToStringReg(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: date)
    }
}
