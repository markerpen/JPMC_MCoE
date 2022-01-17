//
//  Utility.swift
//  JPMC MCoE
//
//  Created by John McEvoy on 17/01/2022.
//

import Foundation

class Utility
{
    // Bare-bones JSON encoder/decoder helper functions
    // (in production these would include date formatters for non-standard JSON datetimes etc.)
    
    static func encodeJSON<T: Codable>(_ value: T?) -> String?
    {
        guard let safeValue = value else
        {
            return nil
        }
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(safeValue)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return nil
    }
    
    static func decodeJSON<T: Codable>(_ jsonString: String?) -> T?
    {
        guard let jsonString = jsonString else
        {
            return nil
        }
        
        guard let data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) as Data? else {
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let obj = try decoder.decode(T.self, from: data)
            return obj
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
