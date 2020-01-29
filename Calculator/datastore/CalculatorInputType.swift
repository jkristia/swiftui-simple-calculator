//
//  CalculatorInputType.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/26/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation

enum CalculatorInputType: Int, CaseIterable {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case decimal
    case equal, plus, minus, multiply, divide
    case clear, invert, percent, back
    
    var title: String? {
        get {
            switch self {
            case .decimal: return "."
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .zero: return "0"
            default:
                return nil
            }
        }
    }
    var asOperation: ArithmicOperatorType? {
        get {
            switch self {
            case .plus: return .add
            case .minus: return .subtract
            case .multiply: return .multiply
            case .divide: return .divide
            default: return nil
            }
        }
    }
}

