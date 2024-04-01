//
//  ContentView.swift
//  UnitConverterChallenge
//
//  Created by Yannick Severo on 29/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum UnitTypes: String, CaseIterable {
        case temperature = "temperature"
        case length = "length"
        case time = "time"
        case volume = "volume"
    }
    @State private var selectedOption = UnitTypes.temperature
    
    enum LengthUnit: String, CaseIterable {
        case meters = "meters"
        case kilometers = "kilometers"
        case feet = "feet"
        case yards = "yards"
        case miles = "miles"
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Picker("Select a unit category", selection: $selectedOption) {
                        ForEach(UnitTypes.allCases, id: \.self) {
                            unit in
                            Text(unit.rawValue.capitalized).tag(unit)
                        }
                    }
                }
                
                if (selectedOption == UnitTypes.temperature) {
                    TemperatureConversionView()
                }
                if (selectedOption == UnitTypes.length) {
                    Text("length")
                }
                if (selectedOption == UnitTypes.time) {
                    Text("time")
                }
                if (selectedOption == UnitTypes.volume) {
                    Text("volmume")
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
