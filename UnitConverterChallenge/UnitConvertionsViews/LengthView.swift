//
//  LengthView.swift
//  UnitConverterChallenge
//
//  Created by Yannick Severo on 01/04/2024.
//

import SwiftUI

struct LengthConversionView: View {
    enum LengthUnit: String, CaseIterable {
        case meters = "meters"
        case kilometers = "km"
        case feet = "feet"
        case yards = "yards"
        case miles = "miles"
    }
    
    @State private var inputLengthUnit = LengthUnit.meters
    @State private var outLengthUnit = LengthUnit.meters
    @State private var inputValue: Double = 0.0
    @State private var outputValue: Double = 0.0
    
    var body: some View {
        VStack {
            Section {
                TextField("Enter your \(inputLengthUnit.rawValue) temperature", text: Binding<String>(
                    get: { String(self.inputValue) },
                    set: { newValue in self.inputValue = Double(newValue) ?? self.inputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerLength(unit: $inputLengthUnit)
            }
            
            Section {
                TextField("Enter your \(outLengthUnit.rawValue) temperature", text: Binding<String>(
                    get: { String(self.outputValue) },
                    set: { newValue in self.outputValue = Double(newValue) ?? self.outputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerLength(unit: $outLengthUnit)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.convertLength()
                    }) {
                        Text("Convert Length")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                    .padding()
                }
            }
        }
    }
    
    private func pickerLength(unit: Binding<LengthUnit>) -> some View {
        Picker(selection: unit, label: Text("Unit")) {
            ForEach(LengthUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func convertLength() {
        switch (inputLengthUnit, outLengthUnit) {
            // Meters Convertions
        case (.meters, .meters):
            outputValue = inputValue
        case (.meters, .kilometers):
            outputValue = inputValue / 1000
        case (.meters, .feet):
            outputValue = inputValue * 3.281
        case (.meters, .miles):
            outputValue = inputValue / 1609
        case (.meters, .yards):
            outputValue = inputValue * 1.094
            // Kilometers convertions
        case (.kilometers, .kilometers):
            outputValue = inputValue
        case (.kilometers, .meters):
            outputValue = inputValue * 1000
        case (.kilometers, .feet):
            outputValue = inputValue * 3281
        case (.kilometers, .miles):
            outputValue = inputValue / 1.609
        case (.kilometers, .yards):
            outputValue = inputValue * 1094
            // Feet convertions
        case (.feet, .feet):
            outputValue = inputValue
        case (.feet, .meters):
            outputValue = inputValue / 3.281
        case (.feet, .kilometers):
            outputValue = inputValue / 3281
        case (.feet, .miles):
            outputValue = inputValue / 5280
        case (.feet, .yards):
            outputValue = inputValue / 3
            // Miles convertions
        case (.miles, .miles):
            outputValue = inputValue
        case (.miles, .meters):
            outputValue = inputValue * 1609
        case (.miles, .kilometers):
            outputValue = inputValue * 1.609
        case (.miles, .feet):
            outputValue = inputValue * 5280
        case (.miles, .yards):
            outputValue = inputValue * 1760
            // Yards convertions
        case (.yards, .yards):
            outputValue = inputValue
        case (.yards, .meters):
            outputValue = inputValue / 1.094
        case (.yards, .kilometers):
            outputValue = inputValue / 1094
        case (.yards, .feet):
            outputValue = inputValue / 3
        case (.yards, .miles):
            outputValue = inputValue / 1760
        }
    }
}
