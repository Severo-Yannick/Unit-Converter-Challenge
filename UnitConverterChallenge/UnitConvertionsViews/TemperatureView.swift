//
//  TemperatureView.swift
//  UnitConverterChallenge
//
//  Created by Yannick Severo on 01/04/2024.
//

import SwiftUI

struct TemperatureConversionView: View {
    enum TemperatureUnit: String, CaseIterable {
        case celsius = "celsius"
        case fahrenheit = "fahrenheit"
        case kelvin = "kelvin"
    }
    
    @State private var inputTemperatureUnit = TemperatureUnit.celsius
    @State private var outTemperatureUnit = TemperatureUnit.celsius
    @State private var inputValue: Double = 0.0
    @State private var outputValue: Double = 0.0
    
    var body: some View {
        VStack {
            Section {
                TextField("Enter your \(inputTemperatureUnit.rawValue) temperature", text: Binding<String>(
                    get: { String(self.inputValue) },
                    set: { newValue in self.inputValue = Double(newValue) ?? self.inputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerTemperature(unit: $inputTemperatureUnit)
            }
            
            Section {
                TextField("Enter your \(outTemperatureUnit.rawValue) temperature", text: Binding<String>(
                    get: { String(self.outputValue) },
                    set: { newValue in self.outputValue = Double(newValue) ?? self.outputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerTemperature(unit: $outTemperatureUnit)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.convertTemperature()
                    }) {
                        Text("Convert")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
    
    private func pickerTemperature(unit: Binding<TemperatureUnit>) -> some View {
        Picker(selection: unit, label: Text("Unit")) {
            ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func convertTemperature() {
        switch (inputTemperatureUnit, outTemperatureUnit) {
        case (.celsius, .celsius):
            outputValue = inputValue
        case (.celsius, .fahrenheit):
            outputValue = (inputValue * 9/5) + 32
        case (.celsius, .kelvin):
            outputValue = inputValue + 273.15
        case (.fahrenheit, .celsius):
            outputValue = (inputValue - 32) / 1.8
        case (.fahrenheit, .fahrenheit):
            outputValue = inputValue
        case (.fahrenheit, .kelvin):
            outputValue = (inputValue + 459.67) / 1.8
        case (.kelvin, .celsius):
            outputValue = inputValue - 273.15
        case (.kelvin, .fahrenheit):
            outputValue = (inputValue * 1.8) - 459.67
        case (.kelvin, .kelvin):
            outputValue = inputValue
        }
    }
}
