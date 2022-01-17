//
//  Networking.swift
//  JPMC MCoE
//
//  Created by John McEvoy on 17/01/2022.
//

import Foundation

class Networking
{
    // this is a simple function which uses
    // URLSession to download the JSON from the external API,
    // decodes it to the PlanetsAPIResponse model,
    // and returns an array of strings representing the planet names
    
    static func getPlanetNames(
        success: @escaping ([String]) -> Void,
        failure: @escaping (String) -> Void)
    {
        // this function is async and has two callbacks, success and failure
        // First check to see if the persistent cache already has the list,
        // and if so, return it immediately and exit the function
        
        if (Persistence.exists("planets"))
        {
            let planetNames = Persistence.getList("planets") as [String]
            
            if (planetNames.count > 0)
            {
                success(planetNames)
                return
            }
        }
        
        // if we got to this point there's no list in the cache.
        // Let's request the data using the standard URLSession object,
        // and to avoid identation (the golden path) let's make use of
        // Swift's 'guard let' to perform sanity checks as we go.
        
        let planetsApiUrl = "https://swapi.dev/api/planets/?format=json"
        
        guard let url = URL(string: planetsApiUrl) else {
            failure("Sorry, this URL is not valid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else {
                failure("Sorry, we couldn't download that data")
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(PlanetsAPIResponse.self, from: data) else {
                failure("Sorry, the JSON we received can't be parsed")
                return
            }
            
            var planetNames: [String] = []
            
            for planet in decodedData.results
            {
                planetNames.append(planet.name)
            }
            
            // we now have the planets list. Let's save it to the cache
            // before calling the success callback
            
            Persistence.setList("planets", list: planetNames)
            success(planetNames)
        }
        task.resume()
    }
}
