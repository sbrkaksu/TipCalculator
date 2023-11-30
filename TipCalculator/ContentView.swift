//
//  ContentView.swift
//  TipCalculator
//
//  Created by Berk Aksu on 30.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isCheckFocused:Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var amountPerPerson: Double{
        //Add two as the first index of a collection is zero
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        //The price to be paid by each person
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    //Use local currency if exist, if not, make it USD
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    //Bind the visibility of keyboard
                        .focused($isCheckFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Total Check")
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Each Should Pay")
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                //Locate toolbar over the keyboard
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        //Toggle the visibility of keyboard
                        isCheckFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
