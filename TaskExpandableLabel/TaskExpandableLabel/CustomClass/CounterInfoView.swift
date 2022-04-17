//
//  CounterInfoView.swift
//  TaskExpandableLabel
//
//  Created by Igor Ashurkov on 17.04.2022.
//

import UIKit

final class CounterInfoView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.drawSelf()
    }
    
    
    // MARK: - Public methods
    
    func setup(counter: Int, title: String) {
        self.counterLabel.text = String(counter)
        self.titleLabel.text = title
    }
    
    
    // MARK: - Private methods
    
    private func drawSelf() {
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.counterLabel)
        self.addSubview(self.titleLabel)
        
        let constraintsForCountreLabel = self.constraintsForCountreLabel()
        let constraintsForTitleLabel = self.constraintsForTitleLabel()
        
        NSLayoutConstraint.activate(
            constraintsForCountreLabel +
            constraintsForTitleLabel
        )
    }
    
    private func constraintsForCountreLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.counterLabel.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingAnchor = self.counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = self.counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor
        ]
    }
    
    private func constraintsForTitleLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.titleLabel.topAnchor.constraint(equalTo: self.counterLabel.bottomAnchor)
        let leadingAnchor = self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor
        ]
    }
}
