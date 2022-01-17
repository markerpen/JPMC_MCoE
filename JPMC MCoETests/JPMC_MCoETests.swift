//
//  JPMC_MCoETests.swift
//  JPMC MCoETests
//
//  Created by John McEvoy on 17/01/2022.
//

import XCTest
@testable import JPMC_MCoE

class JPMC_MCoETests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // The tests below are designed to test functions that are asynchronous
    // (both tests require network requests)
    // so they use expectations to allow for async events

    func testPlanetsAPIAsyncCallback() { // tests for a successful network connection
        
        let expectation = expectation(description: "Request list of planets from external API; should receive list of strings in callback 'success'.")
        
        Networking.getPlanetNames(success: { result in
            
            XCTAssert(
                result.count > 0,
                "Network request was successful")
            
            expectation.fulfill()
            
        }, failure: { errorMessage in
            XCTFail("Couldn't receive list of planets - reason: \(errorMessage)")
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Network request timed out: \(error)")
            }
        }
    }
    
    func testPlanetsPersistence() { // tests the persistence cache saves the Planets list correctly
        let expectation = expectation(description: "Clear persistent cache, then call Networking.getPlanetNames again. If the list in the cache is more than zero, the persistent cache is working.")
        
        Persistence.eraseEverything()
        
        var planetsList = Persistence.getList("planets") as [String]
        
        if (planetsList.count > 0)
        {
            XCTFail("Erase failed: persistent cache still has the 'planets' entry")
        }
        
        Networking.getPlanetNames(success: { result in
            
            planetsList = Persistence.getList("planets") as [String]
            
            XCTAssert(
                planetsList.count > 0,
                "Planets list successfully repopulated")
            
            expectation.fulfill()
            
        }, failure: { errorMessage in
            XCTFail("Couldn't receive list of planets - reason: \(errorMessage)")
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Network request timed out: \(error)")
            }
        }
    }
    
}
