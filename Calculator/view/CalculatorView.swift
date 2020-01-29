//
//  ContentView.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/14/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//
import Combine;
import SwiftUI

struct CalculatorView: View {
    @ObservedObject var store: CalculatorStore
    let padding = CGFloat(15)
    let buttons = CalculatorButtons().basicLayout()
    var body: some View {
        return ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack (spacing: self.padding) {
                GeometryReader { proxy in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(self.store.displayValue)
                                .foregroundColor(.white)
                                .font(.system(size: 64))
                        }
                        .padding()
                        .minimumScaleFactor(0.3)
                    }
                }
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: self.padding) {
                        ForEach( row, id: \.self) { button in
                            CalculatorButtonView(store: self.store, button: button)
                        }
                    }
                }
            }
            .frame(width: ViewSize().width())
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(store: CalculatorStore())
    }
}
