//
//  Persistence.swift
//  JPMC MCoE
//
//  Created by John McEvoy on 17/01/2022.
//

import Foundation

class Persistence
{
    // This is a very simple set of helper functions that sit on top of UserDefaults.
    //
    // All serialisable objects (i.e. arrays) are encoded and decoded to/from JSON
    // (just for debugging by manually inspecting the PLIST file on the simulator if needed).
    
    static func exists(_ key: String) -> Bool
    {
        let defaults = UserDefaults.standard
        
        guard (defaults.object(forKey: key) as? String) != nil else
        {
            return false
        }
        
        return true
    }
    
    static func getList<T: Codable>(_ key: String) -> [T]
    {
        let defaults = UserDefaults.standard
        
        guard let payloadValue = defaults.object(forKey: key) as? String else
        {
            return []
        }
        
        guard let list = Utility.decodeJSON(payloadValue) as [T]? else
        {
            return []
        }
        
        return list
    }
    
    static func setList<T: Codable>(_ key: String, list: [T])
    {
        let defaults = UserDefaults.standard
        let jsonString = Utility.encodeJSON(list)
        
        guard let json = jsonString else
        {
            return
        }
        
        defaults.set(json, forKey: key)
    }
    
    static func eraseEverything()
    {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
