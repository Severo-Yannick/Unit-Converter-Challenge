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
                    LengthConversionView()
                }
                if (selectedOption == UnitTypes.time) {
                    TimeConversionView()
                }
                if (selectedOption == UnitTypes.volume) {
                    VolumeConversionView()
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
