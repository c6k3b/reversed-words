import XCTest

class ReverseWordsUITest: XCTestCase {
    private let app = XCUIApplication()
    private var view: XCUIElement!
    private var actionButton: XCUIElement!
    private var inputTextField: XCUIElement!
    private var resultLabel: XCUIElement!
    
    private var textToIgnoreTextField: XCUIElement!
    private var rulesDescriptionLabel: XCUIElement!
    private var segmentedControls: XCUIElement!
    
    override func setUp() {
        super.setUp()
        app.launch()
        view = app.otherElements["view"].firstMatch
        actionButton = app.buttons["actionButton"].firstMatch
        inputTextField = app.textFields["inputTextField"].firstMatch
        resultLabel = app.staticTexts["resultLabel"].firstMatch

        textToIgnoreTextField = app.textFields["textToIgnoreTextField"].firstMatch
        rulesDescriptionLabel = app.staticTexts["rulesDescriptionLabel"].firstMatch
        segmentedControls = app.segmentedControls.element(boundBy: 0).firstMatch
    }
    
    func testTappingOnActionButtonWithTapOnViewForKeyboardDismiss() {
        inputTextField.tap()
        inputTextField.typeText("Foxminded cool 24/7")
        view.tap()
        actionButton.tap()
        XCTAssertTrue(resultLabel.label.elementsEqual("dednimxoF looc 24/7"))
    }
    
    func testTappingOnActionButtonWithTapOnReturnForKeyboardDismiss() {
        inputTextField.tap()
        inputTextField.typeText("a1bcd efg!h")
        inputTextField.typeText("\n")
        actionButton.tap()
        XCTAssertTrue(resultLabel.label.elementsEqual("d1cba hgf!e"))
    }
    
    func testTappingOnSegmentedControlsSwitchingLabelWithTextField() {
        XCTAssertTrue(segmentedControls.buttons.element(boundBy: 0).isSelected)
        XCTAssertTrue(rulesDescriptionLabel.exists)
        segmentedControls.buttons.element(boundBy: 1).tap()
        XCTAssertTrue(segmentedControls.buttons.element(boundBy: 1).isSelected)
        XCTAssertTrue(textToIgnoreTextField.exists)
    }
    
    func testTappingOnActionButtonWithIgnoringFilter() {
        inputTextField.tap()
        inputTextField.typeText("a1bcd efglh")
        view.tap()
        segmentedControls.buttons.element(boundBy: 1).tap()
        textToIgnoreTextField.tap()
        textToIgnoreTextField.typeText("xl")
        view.tap()
        actionButton.tap()
        XCTAssertTrue(resultLabel.label.elementsEqual("dcb1a hgfle"))
    }
}
