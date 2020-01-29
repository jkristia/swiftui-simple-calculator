//
//  CalculatorButton.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/19/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//
import SwiftUI

enum ButtonColor {
    case digit
    case operand
    case other

    var asColor: Color {
        switch self {
        case .digit: return Color(.lightGray)
        case .operand: return Color(.systemOrange)
        case .other: return Color(.darkGray)
        }
    }
}

struct CalculatorButton: Hashable {
    let type: CalculatorInputType
    var name: String
    let color: ButtonColor

    init(type: CalculatorInputType, color: ButtonColor, name: String? = nil) {
        self.type = type;
        self.name = name ?? ""
        if let n = type.title {
            self.name = n;
        }
        self.color = color;
    }
    func isDigit() -> Bool {
        switch type {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return true;
        case .decimal:
            return true
        default:
            return false;
            
        }
    }
    func isOperand() -> Bool {
        switch type {
        case .plus, .minus, .multiply, .divide:
            return true;
        default:
            return false;
        }
    }
}

