//
//  UILabel.swift
//  TaskExpandableLabel
//
//  Created by Igor Ashurkov on 17.04.2022.
//

import UIKit

extension UILabel {
    
    func addReadmoreButton(for fullText: String?, trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText = trailingText + moreText
        
        let lengthForVisibleString = self.visibleTextLength(for: fullText)
        if lengthForVisibleString == 0 { return }
        
        if let myText = fullText {
            let mutableString = myText
            let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: myText.count - lengthForVisibleString), with: "")
            let readMoreLength = readMoreText.count
            guard let safeTrimmedString = trimmedString else { return }
            if safeTrimmedString.count <= readMoreLength { return }
            
            let trimmedForReadMore = (safeTrimmedString as NSString).replacingCharacters(in: NSRange(location: safeTrimmedString.count - readMoreLength, length: readMoreLength), with: "") + trailingText
            
            let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14.0)])
            let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
            answerAttributed.append(readMoreAttributed)
            self.attributedText = answerAttributed
        }
    }
    
    func addReadlessButton(for fullText: String, trailingText: String, lessText: String, lessTextFont: UIFont, lessTextColor: UIColor) {
        let textForReadless = fullText + trailingText
        
        let answerAttributed = NSMutableAttributedString(string: textForReadless, attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14.0)])
        let readLessAttributed = NSMutableAttributedString(string: lessText, attributes: [NSAttributedString.Key.font: lessTextFont, NSAttributedString.Key.foregroundColor: lessTextColor])
        answerAttributed.append(readLessAttributed)
        self.attributedText = answerAttributed
    }
    
    func visibleTextLength(for fullText: String? = nil) -> Int {
        
        let font: UIFont = self.font
        let mode = self.lineBreakMode
        let labelWidth = self.frame.size.width
        let labelHeight = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        if let myText = fullText {
            let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
            let attributedText = NSAttributedString(string: myText, attributes: attributes as? [NSAttributedString.Key : Any])
            let boundingRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
            
            if boundingRect.size.height > labelHeight {
                var index = 0
                var prev = 0
                let characterSet = CharacterSet.whitespacesAndNewlines
                repeat {
                    prev = index
                    if mode == NSLineBreakMode.byCharWrapping {
                        index += 1
                    } else {
                        index = (myText as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: myText.count - index - 1)).location
                    }
                } while index != NSNotFound && index < myText.count && (myText as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
                return prev
            }
        }
        
        return fullText == nil
            ? 0
            : fullText?.count ?? 0
    }
}
