//
//  CalculatorButtons_test.swift
//  CalculatorFromYoutubeTests
//
//  Created by jesper kristiansen on 1/20/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import XCTest
@testable import CalculatorFromYoutube

class ArithmicOperation_tests: XCTestCase {
    
    func test_verifyCurrentValue() {
        let op = ArithmicOperation()
        XCTAssertNil(op.leftOperand)
        XCTAssertNil(op.operation)
        XCTAssertNil(op.rightOperand)
        XCTAssertNil(op.currentValue)
        
        op.currentValue = "123"
        XCTAssertEqual(op.currentValue, "123")
        XCTAssertEqual(op.leftOperand, "123")
        XCTAssertNil(op.operation)
        XCTAssertNil(op.rightOperand)
        
        op.operation = .add
        XCTAssertEqual(op.operation, .add)
        XCTAssertEqual(op.currentValue, nil)
        op.currentValue = "456"
        XCTAssertEqual(op.currentValue, "456")
        XCTAssertEqual(op.leftOperand, "123")
        XCTAssertEqual(op.operation, .add)
        XCTAssertEqual(op.rightOperand, "456")
        
        op.clear()
        XCTAssertNil(op.leftOperand)
        XCTAssertNil(op.operation)
        XCTAssertNil(op.rightOperand)
        XCTAssertNil(op.currentValue)
    }

    func test_verifyFormatDisplayValue() {
        let op = ArithmicOperation()
        XCTAssertEqual(op.formatDisplayValue(), "0")
        op.currentValue = "123"
        XCTAssertEqual(op.formatDisplayValue(), "123")
        op.operation = .add
        XCTAssertEqual(op.formatDisplayValue(), "123 +")
        op.currentValue = "456"
        XCTAssertEqual(op.formatDisplayValue(), "123 + 456")
    }
    
    func test_operators() {
        var op = ArithmicOperation()
        XCTAssertNil(op.calculate())
        op.leftOperand = "1"
        XCTAssertNil(op.calculate())
        op.operation = .add
        XCTAssertNil(op.calculate())
        op.rightOperand = "2"
        XCTAssertEqual(op.calculate(), 3)
        
        op = ArithmicOperation(left: "2", op: .add, right: "3")
        XCTAssertEqual(op.calculate(), 5)
        op = ArithmicOperation(left: "2", op: .subtract, right: "3")
        XCTAssertEqual(op.calculate(), -1)
        op = ArithmicOperation(left: "2", op: .multiply, right: "3")
        XCTAssertEqual(op.calculate(), 6)
        op = ArithmicOperation(left: "2", op: .divide, right: "3")
        XCTAssertEqual(op.calculate(), 2 / 3)
    }
    func test_setLeftValue() {
        let op1 = ArithmicOperation(left: "10", op: .divide, right: "3")
        XCTAssertEqual(op1.calculatedValueAsString(), "3.333333333333")
        let op2 = ArithmicOperation(leftResult: op1)
        XCTAssertEqual(op2.leftOperand, "3.333333333333")
        XCTAssertEqual(op2.presiceLeftValue, 10.0 / 3.0)
        op2.operation = .multiply
        op2.rightOperand = "3"
        XCTAssertEqual(op2.calculatedValueAsString(), "10")
        
        op2.clear()
        XCTAssertNil(op2.presiceLeftValue)
    }
    func test_invertValue() {
        var op1 = ArithmicOperation()
        op1.leftOperand = "10"
        op1.handleInvert()
        XCTAssertEqual(op1.formatDisplayValue(), "-10")
        op1.operation = .add
        op1.rightOperand = "5"
        XCTAssertEqual(op1.formatDisplayValue(), "-10 + 5")
        XCTAssertEqual(op1.calculatedValueAsString(), "-5")
        
        op1 = ArithmicOperation(left: "5", op: .add, right: "5")
        XCTAssertEqual(op1.formatDisplayValue(), "5 + 5")
        op1.handleInvert()
        XCTAssertEqual(op1.formatDisplayValue(), "5 + -5")
        XCTAssertEqual(op1.calculate(), 0)
        
        op1 = ArithmicOperation()
        op1.leftOperand = "50"
        op1.handleInvert()
        op1.operation = .add
        op1.rightOperand = "2"
        XCTAssertEqual(op1.calculatedValueAsString(), "-48")
    }
    func test_invertPresiceValue() {
        let op1 = ArithmicOperation(left: "10", op: .subtract, right: "3")
        let op2 = ArithmicOperation(leftResult: op1)
        op2.handleInvert()
        XCTAssertEqual(op2.formatDisplayValue(), "-7")
        XCTAssertEqual(op2.presiceLeftValue, -7)
        op2.operation = .add
        op2.rightOperand = "7"
        XCTAssertEqual(op2.calculate(), 0)
        
        // make sure value is clear if left string value is set
        op2.operation = nil
        op2.rightOperand = nil;
        XCTAssertEqual(op2.presiceLeftValue, -7)
        op2.currentValue = "123"
        XCTAssertEqual(op2.presiceLeftValue, nil)
    }
    func test_backOperation() {
        let op1 = ArithmicOperation(left: "10", op: .subtract, right: "31")
        XCTAssertEqual(op1.formatDisplayValue(), "10 - 31")
        op1.handleBack()
        XCTAssertEqual(op1.formatDisplayValue(), "10 - 3")
        op1.handleBack()
        XCTAssertEqual(op1.formatDisplayValue(), "10 -")
        XCTAssertEqual(op1.rightOperand, nil)
        op1.handleBack()
        XCTAssertEqual(op1.formatDisplayValue(), "10")
        XCTAssertEqual(op1.operation, nil)
        op1.handleBack()
        XCTAssertEqual(op1.formatDisplayValue(), "1")
        op1.handleBack()
        XCTAssertEqual(op1.formatDisplayValue(), "0")
    }
    func test_handleInut() {
        func addDigits(op: ArithmicOperation, input: String) {
            input.forEach() { character in
                let type = CalculatorInputType.allCases.first { (buttontype) -> Bool in
                    if let title = buttontype.title {
                        return title == String(character)
                    }
                    return false;
                }
                op.handleDigitInput(type: type!)
            }
        }
        var op1 = ArithmicOperation()
        addDigits(op: op1, input: "1234567890")
        XCTAssertEqual(op1.formatDisplayValue(), "1234567890")
        var op2 = op1.handleOperationInput(type: .minus)
        XCTAssertNil(op2, "must return nil")
        addDigits(op: op1, input: "1234567891")
        XCTAssertEqual(op1.formatDisplayValue(), "1234567890 - 1234567891")
        XCTAssertEqual(op1.calculatedValueAsString(), "-1")
        op2 = op1.handleOperationInput(type: .plus)
        XCTAssertNotNil(op2, "adding operation to existing complete operation returns new operation")
        XCTAssertEqual(op2?.formatDisplayValue(), "-1 +")
        
        // check when equal is set, any digits should be added to 'leftl
        op1 = ArithmicOperation(left: "10", op: .divide, right: "2")
        op2 = ArithmicOperation(leftResult: op1).setClearOnInput()
        XCTAssertEqual(op2?.formatDisplayValue(), "5")
        addDigits(op: op2!, input: "12.34")
        XCTAssertEqual(op2?.leftOperand, "12.34")
        XCTAssertEqual(op2?.formatDisplayValue(), "12.34")
    }
    func test_backShouldClearAfterEqual() {
        let op1 = ArithmicOperation(left: "10", op: .add, right: "2").setClearOnInput()
        let op2 = ArithmicOperation(leftResult: op1).setClearOnInput()
        XCTAssertEqual(op2.formatDisplayValue(), "12")
        op2.handleBack()
        XCTAssertEqual(op2.formatDisplayValue(), "0")
    }
    func test_removeThousandSeparatorOnCalculate() {
        let op1 = ArithmicOperation(left: "195,3", op: .add, right: "2")
        XCTAssertEqual(op1.calculatedValueAsString(), "1,955")
    }
    func test_handlePercent() {
        var op1 = ArithmicOperation()
        op1.leftOperand = "25"
        op1.handlePercent()
        XCTAssertEqual(op1.formatDisplayValue(), "0.25")
        
        op1 = ArithmicOperation(left: "50", op: .add, right: "5")
        op1.handlePercent()
        XCTAssertEqual(op1.formatDisplayValue(), "50 + 2.5")
        XCTAssertEqual(op1.calculatedValueAsString(), "52.5")
    }
}
