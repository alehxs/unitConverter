import SwiftUI

struct ContentView: View {
    @State private var unit1: Double = 0.0
    @State private var unit2: Double = 0.0
    
    let units = ["meters", "kilometers", "feet", "yards", "miles"]
    @State private var inputUnit = "meters"
    @State private var outputUnit = "kilometers"
    
    @FocusState private var isFocused: Bool
    
    private var numberFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    static let conversionRates: [String: Double] = [
            "meters": 1.0,
            "kilometers": 1000.0,
            "feet": 0.3048,
            "yards": 0.9144,
            "miles": 1609.34
        ]

        var convertedValue: Double {
            guard let inputRate = ContentView.conversionRates[inputUnit],
                  let outputRate = ContentView.conversionRates[outputUnit] else {
                return 0.0
            }
            
            let baseValue = unit1 * inputRate
            return baseValue / outputRate
        }
    


    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    HStack {
                        TextField("Enter value", value: $unit1, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .font(.system(size: 20))
                        
                        
                        Picker("", selection: $inputUnit) { //
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.accentColor)
                    .padding()
                    Text("↓")
                        .font(.system(size: 40)) // Adjust the size of the convert sign
                        .padding()
                        .padding()
                        .background(Color(UIColor.systemBackground))
                    
                    HStack {
                        Text(convertedValue, format: .number)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .font(.system(size: 20))
                            .background(Color(UIColor.systemBackground))
                    
                            
                        Picker("", selection: $outputUnit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.accentColor)
                    .padding()
                    
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    if isFocused{
                        Button("Done"){
                            isFocused = false
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    ContentView()
}
