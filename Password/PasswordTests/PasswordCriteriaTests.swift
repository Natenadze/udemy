//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Davit Natenadze on 21.02.23.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {

    // Boundary conditions 8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("32323232323232323232323232323232"))
    }
}

class PasswordOtherCriteriaTests: XCTestCase {
    
    // MARK: - Space
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }

    // MARK: - Length and Space
    func testLengthAndNoSpaceMet() throws {
        // True
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345678"))
        // False
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567 8"))
    }

    // MARK: - Upper Case
    func testUpperCaseMet() throws {
        // True
        XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
        // False
        XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
    }

// MARK: - Lower Case
    func testLowerCaseMet() throws {
        // True
        XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
        // False
        XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
    }

    // Or write separately.
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("1"))
    }

    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("a"))
    }
    
    func testSpecicalCharMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharMet("@"))
    }

    func testSpecicalCharNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharMet("a"))
    }
}
