//
//  CalcultorButtonComponent.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/19/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import SwiftUI


struct CalculatorButtonView: View {
    var store: CalculatorStore
    var button: CalculatorButton
    let padding = CGFloat(15)

    var body: some View {
        Button(action: {
            self.store.onInput(self.button)
        }) {
            Text(button.name)
                .font(.largeTitle)
                .frame(width: self.buttonWidth(button), height: self.buttonHeight(button))
                .foregroundColor(.white)
                .background(button.color.asColor)
                .cornerRadius(CGFloat(10))
        }
    }
    private func buttonWidth(_ button: CalculatorButton) -> CGFloat {
        let width = ViewSize().width();
        return (width - (5 * padding)) / 4
    }
    private func buttonHeight(_ button: CalculatorButton) -> CGFloat {
        return buttonWidth(button)
    }
}
