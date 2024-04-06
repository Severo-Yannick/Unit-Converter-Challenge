//
//  Time.swift
//  UnitConverterChallenge
//
//  Created by Yannick Severo on 05/04/2024.
//

import SwiftUI

struct TimeConversionView: View {
    enum TimeUnit: String, CaseIterable {
        case seconds = "seconds"
        case minutes = "minutes"
        case hours = "hours"
        case days = "days"
    }
    
    @State private var inputTimeUnit = TimeUnit.seconds
    @State private var outTimeUnit = TimeUnit.seconds
    @State private var inputValue: Double = 0.0
    @State private var outputValue: Double = 0.0
    
    var body: some View {
        VStack {
            Section {
                TextField("Enter your \(inputTimeUnit.rawValue) time", text: Binding<String>(
                    get: { String(self.inputValue) },
                    set: { newValue in self.inputValue = Double(newValue) ?? self.inputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerTime(unit: $inputTimeUnit)
            }
            
            Section {
                TextField("Enter your \(outTimeUnit.rawValue) time", text: Binding<String>(
                    get: { String(self.outputValue) },
                    set: { newValue in self.outputValue = Double(newValue) ?? self.outputValue }
                ))
                .keyboardType(.decimalPad)
                
                pickerTime(unit: $outTimeUnit)
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.convertTime()
                    }) {
                        Text("Convert Time")
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
    
    private func pickerTime(unit: Binding<TimeUnit>) -> some View {
        Picker(selection: unit, label: Text("Unit")) {
            ForEach(TimeUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue).tag(unit)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func convertTime() {
        switch (inputTimeUnit, outTimeUnit) {
            // Seconds Convertions
        case (.seconds, .seconds):
            outputValue = inputValue
        case (.seconds, .minutes):
            outputValue = inputValue / 60
        case (.seconds, .hours):
            outputValue = inputValue / 3600
        case (.seconds, .days):
            outputValue = inputValue / 86400
            // Minutes convertions
        case (.minutes, .minutes):
            outputValue = inputValue
        case (.minutes, .hours):
            outputValue = inputValue / 60
        case (.minutes, .days):
            outputValue = inputValue / 1440
        case (.minutes, .seconds):
            outputValue = inputValue * 60
            // Hours convertions
        case (.hours, .hours):
            outputValue = inputValue
        case (.hours, .seconds):
            outputValue = inputValue * 3600
        case (.hours, .minutes):
            outputValue = inputValue * 60
        case (.hours, .days):
            outputValue = inputValue / 24
            // Days convertions
        case (.days, .days):
            outputValue = inputValue
        case (.days, .seconds):
            outputValue = inputValue * 86400
        case (.days, .minutes):
            outputValue = inputValue * 1440
        case (.days, .hours):
            outputValue = inputValue / 1440
        }
    }
}
