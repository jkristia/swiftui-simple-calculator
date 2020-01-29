//
//  CalculatorOperation.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/20/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//
import Foundation

enum ArithmicOperatorType: String {
    case add, subtract, multiply, divide
}
/*
    Input container, holds <left> <operation> <right> and formats the display value
 */
class ArithmicOperation {
    private var clearOnDigitInput: Bool = false
    private static let MAXINPUTLENGTH = 11
    var presiceLeftValue: Double?
    var leftOperand: String?
    var operation: ArithmicOperatorType? {
        didSet {
            clearOnDigitInput = false
        }
    }
    var rightOperand: String?
    var currentValue: String? {
        get {
            if operation != nil {
                return rightOperand;
            }
            if leftOperand != nil {
                return leftOperand!;
            }
            return nil
        }
        set {
            if operation != nil {
                rightOperand = newValue
                if rightOperand!.isEmpty {
                    rightOperand = nil
                }
            } else {
                leftOperand = newValue
                if leftOperand!.isEmpty {
                    leftOperand = "0"
                }
                presiceLeftValue = nil;
            }
            dump()
        }
    }
    init() {
        dump()
    }
    init(leftResult: ArithmicOperation) {
        self.presiceLeftValue = leftResult.calculate();
        self.leftOperand = leftResult.calculatedValueAsString()
        dump()
    }
    init(left: String, op: ArithmicOperatorType, right: String) {
        self.leftOperand = left
        self.operation = op
        self.rightOperand = right
        dump()
    }
    func handleDigitInput(type: CalculatorInputType) {
        let op = self
        if clearOnDigitInput {
            clear()
        }
        var currentValue = op.currentValue ?? "0"
        if type == .decimal {
            if (currentValue.contains(type.title!)) {
                return
            } else {
                currentValue += type.title!;
                op.currentValue = currentValue
                return;
            }
        }
        if (currentValue == "0") {
            currentValue = ""
        }
        if currentValue.count >= ArithmicOperation.MAXINPUTLENGTH {
            return
        }
        currentValue += type.title!;
        op.currentValue = currentValue
    }
    func handleOperationInput(type: CalculatorInputType) -> ArithmicOperation? {
        let op = self
        if op.leftOperand == nil {
            return nil
        }
        if op.operation == nil {
            op.operation = type.asOperation
            return nil
        }
        if op.rightOperand == nil {
            op.rightOperand = "0"
        }
        let newOperation = ArithmicOperation(leftResult: op)
        newOperation.operation = type.asOperation
        return newOperation;
    }
    func handleInvert() {
        var s = currentValue ?? "0"
        if s.starts(with: "-") {
            let offset = s.index(after: s.startIndex)
            s = String(s[offset...])
        } else {
            s = "-" + s;
        }
        if rightOperand == nil {
            leftOperand = s
            if let left = presiceLeftValue {
                presiceLeftValue = 0 - left
            }
        } else {
            rightOperand = s;
        }
    }
    func handleBack() {
        if clearOnDigitInput {
            clear()
            return;
        }
        if rightOperand == nil && operation != nil {
            operation = nil;
            return
        }
        let r = currentValue ?? "0"
        let offset = r.index(before: r.endIndex)
        currentValue = String(r[..<offset])
    }
    func handlePercent() {
        // if right value given, then right value is percent of left value
        if let right = self.rightOperand {
            let opLeft = leftValueAsdouble()
            let opRight = Double(right)!
            let rightValue = opLeft * (opRight / 100)
            self.rightOperand = formatValue(rightValue)
            return
        }
        if let left = self.leftOperand {
            let value = Double(left)!
            self.leftOperand = formatValue(value / 100)
        }
    }
    func calculatedValueAsString() -> String {
        let d = calculate() ?? 0
        return formatValue(d)
    }
    func calculate() -> Double? {
        guard let _ = self.leftOperand, let right = self.rightOperand, let op = self.operation else {
            return nil;
        }
        let opLeft = leftValueAsdouble()
        let opRight = Double(right)!
        
        switch op {
        case .add:
            return opLeft + opRight;
        case .subtract:
            return opLeft - opRight;
        case .multiply:
            return opLeft * opRight;
        case .divide:
            return opLeft / opRight;
        }
    }
    func clear() {
        presiceLeftValue = nil
        leftOperand = nil;
        operation = nil;
        rightOperand = nil
        clearOnDigitInput = false;
    }
    func formatDisplayValue() -> String {
        guard let left = self.leftOperand else {
            return "0"
        }
        guard let operation = self.operation else {
            return left;
        }
        guard let right = self.rightOperand else {
            return "\(left) \(formatOperation(operation))"
        }
        return "\(left) \(formatOperation(operation)) \(right)"
    }
    func setClearOnInput() -> ArithmicOperation {
        clearOnDigitInput = true
        return self
    }
    private func leftValueAsdouble() -> Double {
        // remove thousand separator from formatters string before converting to double
        let thousandSeparator = NumberFormatter().groupingSeparator ?? ""
        return presiceLeftValue ?? Double(leftOperand!.replacingOccurrences(of: thousandSeparator, with: ""))!
    }
    private func formatValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 12
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value))!
    }
    private func formatOperation(_ op: ArithmicOperatorType) -> String {
        switch op {
        case .add:  return "+"
        case .subtract:  return "-"
        case .multiply:  return "x"
        case .divide:  return "/"
        }
    }
    private func dump() {
//        print("left: \(left ?? "nil") (\(presiceLeftValue ?? nil)), op: \(operation?.rawValue ?? "nil"), right: \(right ?? "nil"), calculated: \(calculate())")
    }
    
}
