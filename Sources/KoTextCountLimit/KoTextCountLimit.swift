// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class KoTextCountLimit {
    public init() {}
    
    private var textCount: Int = 0
    
    public func shouldChangeText(for textInput: UITextInput,
                                 in range: NSRange,
                                 replacementText text: String,
                                 maxCharacterLimit: Int) -> Bool {
        
        if text.isBackspace {
            return true
        }
        
        let currentText = (textInput as? UITextView)?.text ?? (textInput as? UITextField)?.text ?? ""
        
        if currentText.count >= maxCharacterLimit {
            return canAddText(currentText: currentText,
                              replacementText: text,
                              maxCharacterLimit: maxCharacterLimit)
        }
        
        return true
    }
    
    private func canAddText(currentText: String, 
                            replacementText text: String,
                            maxCharacterLimit: Int) -> Bool {
        
        let hasPostPosition = currentText.hasPostPosition
        let isConsonantChar = text.isConsonant
        let isVowelChar = text.isVowel
        let currentTextCount = currentText.utf16.count
        
        if currentTextCount >= maxCharacterLimit {

            if let lastText = currentText.last {
                if lastText.isVowel {
                    return false
                } else if lastText.isConsonant {
                    return isVowelChar
                } else {
                    return isConsonantChar
                }
            }
        }
        
        if !hasPostPosition && isConsonantChar {
            return currentTextCount < maxCharacterLimit
        }
        
        return currentTextCount + text.count <= maxCharacterLimit
    }
    
    public func didChangeText(for textInput: UITextInput, 
                              maxCharacterLimit: Int) {
        guard let textView = textInput as? UITextView else { return  }
        
        if textView.text.count > maxCharacterLimit {
            textView.text = String(textView.text.prefix(maxCharacterLimit))
            self.textCount = maxCharacterLimit
        }
        
        self.textCount = textView.text.count
    }
    
    public func getTextCount() -> Int {
        return self.textCount
    }
}
