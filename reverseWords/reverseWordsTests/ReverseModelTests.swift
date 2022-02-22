import XCTest
@testable import reverseWords

class ReverseModelTests: XCTestCase {

    func testReverseModelWithNormalString() throws {
        let input = "test string"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "tset gnirts")
    }

    func testReverseModelWithCapitalLetters() throws {
        let input = "Test String"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "tseT gnirtS")
    }

    func testReverseModelWithSingleLettersAndSpaces() throws {
        let input = "a b c"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "a b c")
    }

    func testReverseModelWithSpace() throws {
        let input = " "
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, " ")
    }

    func testReverseModelWithoutLetters() throws {
        let input = ""
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertTrue(otput.isEmpty)
    }

    func testReverseModelNotNil() throws {
        let input = ""
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertNotNil(otput)
    }

    func testReverseModelNoThrowError() throws {
        let input = ""
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertNoThrow(otput)
    }
    
    func testDefaultRulesWithNumbers() throws {
        let input = "Foxminded cool 24/7"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "dednimxoF looc 24/7")
    }
    
    func testDefaultRulesSimpleText() throws {
        let input = "abcd efgh"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "dcba hgfe")
    }
    
    func testDefaultRulesWithSpecials() throws {
        let input = "a1bcd efg!h"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .defaultRules)
        XCTAssertEqual(otput, "d1cba hgf!e")
    }

    func testUserDefinedRulesWithNumbers() throws {
        let input = "Foxminded cool 24/7"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .userDefinedRules, ignore: "xl")
        XCTAssertEqual(otput, "dexdnimoF oocl 7/42")
    }
    
    func testUserDefinedRulesWithSimpleText() throws {
        let input = "abcd efgh"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .userDefinedRules, ignore: "xl")
        XCTAssertEqual(otput, "dcba hgfe")
    }
    
    func testUserDefinedRulesWithNumbersInside() throws {
        let input = "a1bcd efglh"
        let otput = ReverseModel().reverseEachWordInString(input, rules: .userDefinedRules, ignore: "xl")
        XCTAssertEqual(otput, "dcb1a hgfle")
    }
}
