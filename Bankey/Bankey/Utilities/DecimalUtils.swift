//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Davit Natenadze on 09.02.23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
