//
//  ContentView.swift
//  RGBAppSwiftUI
//
//  Created by Arthur Lee on 10.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
   
    
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack() {
                ColorView(redValue: redSliderValue/255, greenValue: greenSliderValue/255, blueValue: blueSliderValue/255)
                ValueSettingsStack(value: $redSliderValue, colorSlider: .red)
                ValueSettingsStack(value: $greenSliderValue, colorSlider: .green)
                ValueSettingsStack(value: $blueSliderValue, colorSlider: .blue)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ValueSettingsStack: View {
   
    @Binding var value: Double
    @State private var stringEnteredValue = ""
    @State private var alertPresented = false
    
    let colorSlider: Color
    
    
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .frame(width: 50)
            Slider(value: $value, in: 0...255, step: 1)
                    .accentColor(colorSlider)
                .frame(width: 250)
            TextField("", text: $stringEnteredValue, onCommit: filterTextfield)
                .alert(isPresented: $alertPresented, content: {
                    Alert(title: Text("Wrong Format!"), message: Text("Try again!"))
                })
                .onAppear {
                    stringEnteredValue = "\(lround(value))"
                }
                .onChange(of: value, perform: { value in
                    stringEnteredValue = "\(lround(value))"
                })
                .keyboardType(.numbersAndPunctuation)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
        }
       
    }
    

    private func filterTextfield() {
        if let value = Int(stringEnteredValue),
           (0...255).contains(value) {
            self.value = Double(value)
        } else {
            alertPresented.toggle()
            value = 0
            stringEnteredValue = "0"
        }
    }
}


struct ColorView: View {
    
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        Color(red: redValue, green: greenValue, blue: blueValue)
            .frame(width: 360, height: 200)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 4))
    }
}
