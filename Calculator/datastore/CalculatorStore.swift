//
//  CalculatorStore.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/19/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation
import Combine;

class CalculatorStore: ObservableObject {
    @Published var displayValue: String = "0"
    private var operations: [ArithmicOperation] = []
    
    func onInput(_ button: CalculatorButton) {
        if button.type == .equal {
            handleEqualInput(type: button.type)
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.type == .clear {
            clear();
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.type == .invert {
            currentOperation.handleInvert()
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.type == .back {
            currentOperation.handleBack()
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.type == .percent {
            currentOperation.handlePercent()
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.isDigit() {
            currentOperation.handleDigitInput(type: button.type)
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
        if button.isOperand() {
            handleOperationInput(type: button.type)
            displayValue = currentOperation.formatDisplayValue()
            return;
        }
    }
    func clear() {
        currentOperation.clear()
    }
    
    private var currentOperation: ArithmicOperation {
        get {
            if operations.isEmpty {
                operations.append(ArithmicOperation())
            }
            return operations.last!
        }
    }
    private func handleOperationInput(type: CalculatorInputType) {
        if let newOperation = currentOperation.handleOperationInput(type: type) {
            operations.append(newOperation)
        }
    }
    private func handleEqualInput(type: CalculatorInputType) {
        let op = currentOperation
        if op.operation == nil {
            return
        }
        let newOperation = ArithmicOperation(leftResult: op).setClearOnInput()
        operations.append(newOperation)
    }
}
