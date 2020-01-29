//
//  SetupKeyboard.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/19/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//
import SwiftUI

class SetupKeyboard {
    public var keys: [UIKeyCommand] = []
    private var selector: Selector? = nil;
    let buttons = CalculatorButtons()
    
    init(selector: Selector) {
        self.selector = selector;
        keys = [
            addKey(input: "0", key: buttons.find(.zero)),
            addKey(input: "1", key: buttons.find(.one)),
            addKey(input: "2", key: buttons.find(.two)),
            addKey(input: "3", key: buttons.find(.three)),
            addKey(input: "4", key: buttons.find(.four)),
            addKey(input: "5", key: buttons.find(.five)),
            addKey(input: "6", key: buttons.find(.six)),
            addKey(input: "7", key: buttons.find(.seven)),
            addKey(input: "8", key: buttons.find(.eight)),
            addKey(input: "9", key: buttons.find(.nine)),
            addKey(input: ".", key: buttons.find(.decimal)),
            
            addKey(input: "+", key: buttons.find(.plus)),
            addKey(input: "-", key: buttons.find(.minus)),
            addKey(input: "*", key: buttons.find(.multiply)),
            addKey(input: "/", key: buttons.find(.divide)),
            addKey(input: "=", key: buttons.find(.equal)),
            addKey(input: "\r", key: buttons.find(.equal)), // return ASCII 13
            addKey(input: "\u{8}", key: buttons.find(.back)), // delete / backspace ASCII 8
            addKey(input: UIKeyCommand.inputEscape, key: buttons.find(.clear)), // ESC
        ]
    }
    
    private func addKey(input: String, key: CalculatorButton) -> UIKeyCommand {
        print("jk \(input)")
        return UIKeyCommand(title: "", action: selector!, input: input, propertyList: key.type.rawValue) // TODO, pass rawValue, getting error if I pass just the enum 
    }
}
