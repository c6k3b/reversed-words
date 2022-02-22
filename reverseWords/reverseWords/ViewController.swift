import UIKit

class ViewController: UIViewController {
    @IBOutlet var inputStringTextField: UITextField!
    @IBOutlet var separator: UILabel!
    @IBOutlet var reversedStringLabel: UILabel!
    @IBOutlet var rulesDescriptionLabel: UILabel!
    @IBOutlet var textToIgnoreTextField: UITextField!
    @IBOutlet var choosingRulesSegmentedControl: UISegmentedControl!
    @IBOutlet var actionButton: UIButton!
    
    typealias Rules = ReverseModel.ReverseRulesList

    private var isReversed = false
    private var reverseRules: Rules = .defaultRules
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        inputStringTextField.delegate = self
        textToIgnoreTextField.delegate = self
        choosingRulesSegmentedControl.addTarget(self, action: #selector(choosenRulesForReverse), for: .valueChanged)
    }

    // Hide keyboard when tapping somewhere on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if inputStringTextField.text!.isBlank { restoreInitialView() }
    }

    // MARK: Actions
    @IBAction func performAction(_ sender: Any) {
        isReversed ? restoreInitialView() : reverseInputStringTextField(rules: reverseRules)
    }

    // MARK: - choosingRulesSegmentControl Actions
    @objc func choosenRulesForReverse() {
        switch choosingRulesSegmentedControl.selectedSegmentIndex {
            case 0:
                reverseRules = .defaultRules
                textToIgnoreTextField.isHidden = true
                rulesDescriptionLabel.isHidden = false
                reversedStringLabel.text?.removeAll()
                restoreActionButtonLabelAndPrepareForAction()
            case 1:
                reverseRules = .userDefinedRules
                textToIgnoreTextField.isHidden = false
                rulesDescriptionLabel.isHidden = true
                reversedStringLabel.text?.removeAll()
                restoreActionButtonLabelAndPrepareForAction()
            default: break
        }
    }

    // MARK: Private Methods
    private func reverseInputStringTextField(rules: Rules) {
        reversedStringLabel.text = ReverseModel().reverseEachWordInString(
            inputStringTextField.text ?? "",
            rules: rules,
            ignore: textToIgnoreTextField.text!)

        actionButton.setTitle("Clear", for: .normal)
        isReversed = true
    }

    private func restoreActionButtonLabelAndPrepareForAction() {
        actionButton.setTitle("Reverse", for: .normal)
        actionButton.isEnabled = true
        isReversed = false
    }
    
    private func restoreInitialView() {
        actionButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.6036138471)
        actionButton.setTitle("Reverse", for: .normal)
        actionButton.isEnabled = false
        separator.backgroundColor = .systemGray6

        inputStringTextField.text?.removeAll()
        reversedStringLabel.text?.removeAll()
        textToIgnoreTextField.text?.removeAll()
        isReversed = false
    }
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        separator.backgroundColor = .systemBlue
        actionButton.backgroundColor = .systemBlue
        actionButton.isEnabled = true
        actionButton.setTitle("Reverse", for: .normal)
        isReversed = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputStringTextField.endEditing(true)
        if inputStringTextField.text!.isBlank { restoreInitialView() }
        return true
    }
}

extension String {
    var isBlank: Bool { allSatisfy({ $0.isWhitespace }) }
}
