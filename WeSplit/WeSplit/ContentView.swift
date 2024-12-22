//
//  ContentView.swift
//  WeSplit
//
//  Created by Jeffri Lieca H on 21/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var totalCheck : Double {
        return checkAmount + (Double(tipPercentage) * checkAmount / 100)
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                

//                Section( header: Text("hjgjkkf"), footer: Text("gkffk")) { Picker("Tip percentage", selection: $tipPercentage) {
//                    ForEach(tipPercentages, id: \.self) {
//                        Text($0, format: .percent)
//                    }
//                }
//                .pickerStyle(.segmented)
//                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
                        ForEach ( 0..<101 ) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount Check") {
                    Text(totalCheck, format: .currency(code:  Locale.current.currency?.identifier ?? "USD") )
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                
                Section ("Amount per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
//                Section {
//                    Text(Locale.current.currency!.identifier)
//                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
