//
//  CalculatorButton.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/15/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import SwiftUI

class CalculatorButtons {
    private var buttons: [CalculatorButton] = []
    
    init() {
        buttons = [
            CalculatorButton(type: .zero, color: .digit),
            CalculatorButton(type: .one, color: .digit),
            CalculatorButton(type: .two, color: .digit),
            CalculatorButton(type: .three, color: .digit),
            CalculatorButton(type: .four, color: .digit),
            CalculatorButton(type: .five, color: .digit),
            CalculatorButton(type: .six, color: .digit),
            CalculatorButton(type: .seven, color: .digit),
            CalculatorButton(type: .eight, color: .digit),
            CalculatorButton(type: .nine, color: .digit),
            CalculatorButton(type: .decimal, color: .digit),
            CalculatorButton(type: .back, color: .digit, name: "←"),

            CalculatorButton(type: .equal, color: .other, name: "="),
            CalculatorButton(type: .plus, color: .operand, name: "+"),
            CalculatorButton(type: .minus, color: .operand, name: "-"),
            CalculatorButton(type: .multiply, color: .operand, name: "×"),
            CalculatorButton(type: .divide, color: .operand, name: "÷"),

            CalculatorButton(type: .clear, color: .other, name: "C"),
            CalculatorButton(type: .invert, color: .other, name: "±"),
            CalculatorButton(type: .percent, color: .other, name: "%"),
        ]
    }
    func find(_ type: CalculatorInputType) ->CalculatorButton {
        return b(type);
    }
    
    func basicLayout() -> [[CalculatorButton]] {
        return [
            [b(.clear), b(.invert),  b(.percent), b(.divide)],
            [b(.seven), b(.eight),   b(.nine),    b(.multiply)],
            [b(.four),  b(.five),    b(.six),     b(.minus)],
            [b(.one),   b(.two),     b(.three),   b(.plus)],
            [b(.zero),  b(.decimal), b(.back),    b(.equal)],
        ]
    }
    
    private func b(_ type: CalculatorInputType) -> CalculatorButton {
        let button  = self.buttons.first { (button) -> Bool in button.type == type};
        return button!;
    }
    
}
