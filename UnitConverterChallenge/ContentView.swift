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
                Section(header: Text(inputTemperatureUnit.rawValue)) {
                    TextField("Enter your \(inputTemperatureUnit.rawValue) temperature", text: Binding<String>(
                        get: { String(self.inputValue) },
                        set: { newValue in self.inputValue = Double(newValue) ?? self.inputValue}
                    ))
                    .keyboardType(.decimalPad)
                    
                    self.pickerTemperature(unit: $inputTemperatureUnit)
                        .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(outTemperatureUnit.rawValue)) {
                    TextField("Enter your \(outTemperatureUnit.rawValue) temperature", text: Binding<String>(
                        get: { String(self.outputValue) },
                        set: { newValue in self.outputValue = Double(newValue) ?? self.outputValue }
                    ))
                    .keyboardType(.decimalPad)
                    
                    self.pickerTemperature(unit: $outTemperatureUnit)
                    
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
            .navigationTitle("Unit Converter")
        }
    }
    
    func pickerTemperature(unit: Binding<TemperatureUnit>) -> some View {
        Picker(selection: unit, label: Text("Unit")) {
            ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    
    func convertTemperature() {
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


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
