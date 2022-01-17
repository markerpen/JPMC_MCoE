//
//  PlanetsAPI.swift
//  JPMC MCoE
//
//  Created by John McEvoy on 17/01/2022.
//

import Foundation

struct PlanetsAPIResponse: Codable {
    var results: [PlanetsAPIResult]
}

struct PlanetsAPIResult: Codable {
    var name: String
}
