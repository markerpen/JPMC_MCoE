//
//  ContentView.swift
//  JPMC MCoE
//
//  Created by John McEvoy on 17/01/2022.
//

import SwiftUI

struct PlanetListView: View {
    
    // A simple SwiftUI view.
    // When the view starts up it shows a loading message
    // and once the network request is complete it changes
    // to either a list of planet names or an error message
    
    @State private var hasLoaded: Bool = false
    @State private var planetNames: [String] = []
    @State private var errorMessage: String? = nil
    
    var body: some View {
        
        VStack {
            
            if (!hasLoaded) // show loading message
            {
                VStack(alignment: .center) {
                    Text("Loading...")
                        .font(.headline)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            
            if (hasLoaded && (errorMessage == nil)) // show list of planet names
            {
                List(planetNames, id: \.self) { planetName in
                    VStack(alignment: .leading) {
                        Text(planetName)
                            .font(.headline)
                    }
                }
            }
            
            if let errorMessage = errorMessage { // show error message
                Text(errorMessage)
                    .font(.headline)
                    .padding(44)
            }
 
        }.onAppear(perform: { // this callback is executed when the view first appears
            
            Networking.getPlanetNames(success: { results in
                planetNames = results
                errorMessage = nil
                hasLoaded = true
            }, failure: { error in
                planetNames = []
                errorMessage = error
                hasLoaded = true
            })
            
        })
    }
}

