//
//  Volume.swift
//  UnitConverterChallenge
//
//  Created by Yannick Severo on 06/04/2024.
//

import SwiftUI

struct VolumeConversionView: View {
    enum VolumeUnit: String, CaseIterable {
        case milliliters = "milliliters"
        case gallons = "gallons"
        case liters = "liters"
        case pints = "pints"
        case cups = "cups"
    }
    
    @State private var inputVolumeUnit = VolumeUnit.milliliters
    @State private var outVolumeUnit = VolumeUnit.milliliters
    @State private var inputValue: Double = 0.0
    @State private var outputValue: Double = 0.0
    
    var body: some View {
        VStack {
            Section {
                TextField("Enter your \(inputVolumeUnit.rawValue) Volume", text: Binding<String>(
                    get: { String(self.inputValue) },
                    set: { newValue in self.inputValue = Double(newValue) ?? self.inputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerVolume(unit: $inputVolumeUnit)
            }
            
            Section {
                TextField("Enter your \(outVolumeUnit.rawValue) Volume", text: Binding<String>(
                    get: { String(self.outputValue) },
                    set: { newValue in self.outputValue = Double(newValue) ?? self.outputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerVolume(unit: $outVolumeUnit)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.convertVolume()
                    }) {
                        Text("Convert Volume")
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
    
    private func pickerVolume(unit: Binding<VolumeUnit>) -> some View {
        Picker(selection: unit, label: Text("Unit")) {
            ForEach(VolumeUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func convertVolume() {
        switch (inputVolumeUnit, outVolumeUnit) {
            // Milliliters Convertions
        case (.milliliters, .milliliters):
            outputValue = inputValue
        case (.milliliters, .liters):
            outputValue = inputValue / 1000
        case (.milliliters, .cups):
            outputValue = inputValue / 236.6
        case (.milliliters, .pints):
            outputValue = inputValue / 568.3
        case (.milliliters, .gallons):
            outputValue = inputValue / 4546
            // Liters convertions
        case (.liters, .liters):
            outputValue = inputValue
        case (.liters, .cups):
            outputValue = inputValue * 4.227
        case (.liters, .gallons):
            outputValue = inputValue / 3.785
        case (.liters, .pints):
            outputValue = inputValue * 2.113
        case (.liters, .milliliters):
            outputValue = inputValue * 1000
            // Cups convertions
        case (.cups, .cups):
            outputValue = inputValue
        case (.cups, .gallons):
            outputValue = inputValue / 16
        case (.cups, .liters):
            outputValue = inputValue / 4.167
        case (.cups, .milliliters):
            outputValue = inputValue * 240
        case (.cups, .pints):
            outputValue = inputValue / 1.972
            // Pints convertions
        case (.pints, .pints):
            outputValue = inputValue
        case (.pints, .gallons):
            outputValue = inputValue / 8
        case (.pints, .liters):
            outputValue = inputValue / 2.113
        case (.pints, .cups):
            outputValue = inputValue * 2
        case (.pints, .milliliters):
            outputValue = inputValue * 473.2
            // Gallons convertions
        case (.gallons, .gallons):
            outputValue = inputValue
        case (.gallons, .cups):
            outputValue = inputValue * 16
        case (.gallons, .liters):
            outputValue = inputValue * 3.785
        case (.gallons, .milliliters):
            outputValue = inputValue * 3785
        case (.gallons, .pints):
            outputValue = inputValue * 8
        }
    }
}
