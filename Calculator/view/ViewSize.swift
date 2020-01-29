//
//  ViewSize.swift
//  CalculatorFromYoutube
//
//  Created by jesper kristiansen on 1/19/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import SwiftUI

struct ViewSize {
    func width() -> CGFloat {
        return min(400, UIScreen.main.bounds.width)
    }
}
