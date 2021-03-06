//
//  SettingsModel.swift
//  AmeliaBoli
//
//  Created by Amelia Boli on 4/21/16.
//  Copyright © 2016 Amelia Boli. All rights reserved.
//

import Foundation

class UserSettings {
    static let sharedInstance = UserSettings()
    
    private init() {
    }
    
    let calendar = NSCalendar.currentCalendar()
    let components = NSDateComponents()
    
    var fromHour = 9
    var fromMinute = 0
    var fromTime: NSDate {
        get {
            components.hour = fromHour
            components.minute = fromMinute
            return calendar.dateFromComponents(components)!
        }
        set(newTime) {
            let components = calendar.components([.Hour, .Minute], fromDate: newTime)
            fromHour = components.hour
            fromMinute = components.minute
        }
    }
    
    var toHour = 17
    var toMinute = 0
    var toTime: NSDate {
        get {
            components.hour = toHour
            components.minute = toMinute
            return calendar.dateFromComponents(components)!
        }
        set(newTime) {
            let components = calendar.components([.Hour, .Minute], fromDate: newTime)
            toHour = components.hour
            toMinute = components.minute
        }
    }
    
    var periodLength: Double {
        return Double((toHour * 60 + toMinute) - (fromHour * 60 + fromMinute))
        
    }
    
    var startMinutesSinceMidnight: Double {
        return Double(fromHour * 60 + fromMinute)
    }
    
    var hecticNumber = 6
    var steadyNumber = 4
    var relaxedNumber = 2
    
    var lastFrequencyPicked = "steady"
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func loadSettings() {
        if let userSettingsFromDefaults = userDefaults.objectForKey("userSettings") as? [String: AnyObject] {
            fromHour = userSettingsFromDefaults["fromHour"] as! Int
            fromMinute = userSettingsFromDefaults["fromMinute"] as! Int
            toHour = userSettingsFromDefaults["toHour"] as! Int
            toMinute = userSettingsFromDefaults["toMinute"] as! Int
            hecticNumber = userSettingsFromDefaults["hecticNumber"] as! Int
            steadyNumber = userSettingsFromDefaults["steadyNumber"] as! Int
            relaxedNumber = userSettingsFromDefaults["relaxedNumber"] as! Int
        }
        if let storedFrequency = userDefaults.stringForKey("frequency") {
            lastFrequencyPicked = storedFrequency
        }
    }
    
    func saveSettings() {
        let userSettingsDict = ["fromHour": fromHour,
                                "fromMinute": fromMinute,
                                "toHour": toHour,
                                "toMinute": toMinute,
                                "hecticNumber": hecticNumber,
                                "steadyNumber": steadyNumber,
                                "relaxedNumber": relaxedNumber]
        userDefaults.setObject(userSettingsDict, forKey: "userSettings")
        userDefaults.setObject(lastFrequencyPicked, forKey: "frequency")

    }
}
