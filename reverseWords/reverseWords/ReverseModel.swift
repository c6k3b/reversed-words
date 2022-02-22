import Foundation

struct ReverseModel {
    enum ReverseRulesList { case defaultRules, userDefinedRules }

    func reverseEachWordInString(_ input: String, rules: ReverseRulesList, ignore: String = "") -> String {
        switch rules {
            case .defaultRules: return reverseByDefault(input: input)
            case .userDefinedRules: return reverseByUserDefined(input: input, ignore: ignore)
        }
    }
    
    private func reverseByDefault(input: String) -> String {
        input
            .components(separatedBy: " ")
            .map { $0.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
                ? String($0.reversed())
                : reverseSingleWord(input: $0) }
            .joined(separator: " ")
    }
    
    private func reverseByUserDefined(input: String, ignore: String) -> String {
        input
            .components(separatedBy: " ")
            .map { word in reverseSingleWord(input: word, ignore: ignore) }
            .joined(separator: " ")
    }

    private func reverseSingleWord(input: String, ignore: String = "") -> String {
        let ignoredSymbolsArray = ignore.isEmpty ? input.notLetters.map { $0 } : ignore.map { $0 }
        var arrayOfCharacters = input.map { $0 }
        var ignoredSymbolsIndices: [(symbol: Character, index: Int)] = []
        
        for symbol in ignoredSymbolsArray {
            while arrayOfCharacters.contains(symbol) {
                ignoredSymbolsIndices += [(symbol: symbol, index: arrayOfCharacters.lastIndex(of: symbol)!)]
                arrayOfCharacters.remove(at: arrayOfCharacters.lastIndex(of: symbol)!)
            }
        }
        
        arrayOfCharacters.reverse()
        ignoredSymbolsIndices.reverse()
        
        for element in ignoredSymbolsIndices {
            arrayOfCharacters.insert(element.symbol, at: element.index)
        }
        
        return arrayOfCharacters.map { String($0) }.joined()
    }
}

extension String {
    var notLetters: String {
        return components(separatedBy: CharacterSet.letters).joined()
    }
}
