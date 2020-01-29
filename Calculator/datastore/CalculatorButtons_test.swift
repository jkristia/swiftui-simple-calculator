//
//  CalculatorButtons_test.swift
//  CalculatorFromYoutubeTests
//
//  Created by jesper kristiansen on 1/20/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import XCTest
@testable import CalculatorFromYoutube

class CalculatorButtons_tests: XCTestCase {
    
    let buttons: CalculatorButtons = CalculatorButtons()
    
    func verify(type: CalculatorInputType, name: String, extra: ((CalculatorButton) -> Bool)? ) {
        let button = buttons.find(type)
        XCTAssertNotNil(button)
        XCTAssertEqual(button.name, name)
        if let fn = extra {
            XCTAssertTrue(fn(button), button.name)
        }
    }
    
    func test_findButtons() {
        verify(type: .zero   , name: "0") { b in b.isDigit() && !b.isOperand() }
        verify(type: .one    , name: "1") { b in b.isDigit() && !b.isOperand() }
        verify(type: .two    , name: "2") { b in b.isDigit() && !b.isOperand() }
        verify(type: .three  , name: "3") { b in b.isDigit() && !b.isOperand() }
        verify(type: .four   , name: "4") { b in b.isDigit() && !b.isOperand() }
        verify(type: .five   , name: "5") { b in b.isDigit() && !b.isOperand() }
        verify(type: .six    , name: "6") { b in b.isDigit() && !b.isOperand() }
        verify(type: .seven  , name: "7") { b in b.isDigit() && !b.isOperand() }
        verify(type: .eight  , name: "8") { b in b.isDigit() && !b.isOperand() }
        verify(type: .nine   , name: "9") { b in b.isDigit() && !b.isOperand() }
        verify(type: .decimal, name: ".") { b in b.isDigit() && !b.isOperand() }
        verify(type: .back   , name: "←") { b in b.isDigit() == false }
        
        verify(type: .plus    , name: "+") { b in !b.isDigit() && b.isOperand() }
        verify(type: .minus   , name: "-") { b in !b.isDigit() && b.isOperand() }
        verify(type: .multiply, name: "x") { b in !b.isDigit() && b.isOperand() }
        verify(type: .divide  , name: "/") { b in !b.isDigit() && b.isOperand() }
    }
}
