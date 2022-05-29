//
//  ContentView.swift
//  Unitify
//
//  Created by Arkadiusz Świętnicki on 29/05/2022.
//

import SwiftUI

struct ContentView: View {
	// Our state variables.
	@State private var valueToConvert = 0.0
	@State private var inputUnit = "Centimeters"
	@State private var outputUnit = "Meters"
	private let units = ["Centimeters", "Meters", "Inches", "Feet"]
	// A pretty dirty computed property containing our conversions.
	var conversion: Double {
		var convertFrom: UnitLength
		var convertTo: UnitLength
		switch inputUnit {
			case "Centimeters":
				convertFrom = UnitLength.centimeters
			case "Meters":
				convertFrom = UnitLength.meters
			case "Inches":
				convertFrom = UnitLength.inches
			case "Feet":
				convertFrom = UnitLength.feet
			default:
				convertFrom = UnitLength.centimeters
		}
		switch outputUnit {
			case "Centimeters":
				convertTo = UnitLength.centimeters
			case "Meters":
				convertTo = UnitLength.meters
			case "Inches":
				convertTo = UnitLength.inches
			case "Feet":
				convertTo = UnitLength.feet
			default:
				convertTo = UnitLength.meters
		}
		return Measurement(value: valueToConvert, unit: convertFrom).converted(to: convertTo).value
	}
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Value to convert", value: $valueToConvert, format: .number).keyboardType(.decimalPad)
					Picker("Input unit", selection: $inputUnit) {
						ForEach(units, id: \.self) {
Text($0)
						}
					}
					Section {
						Picker("Output unit", selection: $outputUnit) {
							ForEach(units, id: \.self) {
								Text($0)
							}
						}
					} header: {
						Text("Into")
					}
					Section {
						// We check if the user is not trying to ocnvert centimeters to centimeters, for example as this would be stupid.
						if inputUnit == outputUnit {
							Text("Input and output units cannot be the same!").background(.red)
						}
						else {
						Text("\(conversion, format: .number) \(outputUnit)")
						}
					} header: {
						Text("Is equal to")
					}
				}
			}.navigationTitle("Unitify")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
