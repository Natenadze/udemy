//
//  PasswordCriteria.swift
//  Password
//
//  Created by Davit Natenadze on 19.02.23.
//

import Foundation

struct PasswordCriteria {
    
    static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    static func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
        
    static func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    static func uppercaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    static func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    static func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    static func specialCharMet(_ text: String) -> Bool {
        let pattern = #"[^a-zA-Z0-9]+"#   // "[@:?!()$#§%,./\\\\]+" if explicitly defined needed
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    


}
