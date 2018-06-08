//
//  DateFormatting.swift
//  detroitLabsChallenge
//
//  Created by may on 2018-06-08.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation

class DateFormatting {
    
    class func creatingTheDateFromTemplate(date: Date, time: Bool) -> String {
        
        // date comes in as String of yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        // Now the date has been converted to Date()
        
//        let date = formatDate.date(from: date)
        
        if (time) {
            // If I need time only, then it will return time only as String
            
            formatDate.dateStyle = .none
            formatDate.timeStyle = .short
            
            return formatDate.string(from: date)
            
        } else {
            // This will return date (no time) as String
            
            formatDate.timeStyle = .none
            formatDate.dateStyle = .medium
            
            // WE need to get the Name of the weekday so we have to convert it as Date
            
            let theDate = formatDate.string(from: date)
            
            formatDate.dateFormat = "EEEE"
            
            let nameOfTheday = formatDate.string(from: date)
            
            return nameOfTheday + " " + theDate
        }
}

}
