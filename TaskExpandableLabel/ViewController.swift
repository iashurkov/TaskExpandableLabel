//
//  ViewController.swift
//  TaskExpandableLabel
//
//  Created by Igor Ashurkov on 17.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Public structures
    
    enum Constants {
        static let recommendedVerticalOffset: CGFloat = 16
        
        static let profileImageViewInset = UIEdgeInsets(top: recommendedVerticalOffset, left: 0, bottom: 0, right: -recommendedVerticalOffset)
        static let profileImageViewSize: CGFloat = 100
        static let profileImageViewCornerRadius = profileImageViewSize / 2
        
        static let nicknameLabelInset = UIEdgeInsets(top: 16, left: recommendedVerticalOffset, bottom: 0, right: -recommendedVerticalOffset)
        static let nicknameLabelHeight: CGFloat = 46
        
        static let profileInfoStackInset = UIEdgeInsets(top: 8, left: recommendedVerticalOffset, bottom: 0, right: -recommendedVerticalOffset)
        static let profileInfoStackHeight: CGFloat = 46
        
        static let descriptionLabelInset = UIEdgeInsets(top: 16, left: recommendedVerticalOffset, bottom: 0, right: -recommendedVerticalOffset)
        static let numberOfLinesLabel = 2
        static let descriptionFont = UIFont.systemFont(ofSize: 14.0)
        static let moreButtonFont = UIFont.boldSystemFont(ofSize: 14.0)
        static let moreButtonColor = UIColor.systemBlue
        
        static let somethingButtonInset = UIEdgeInsets(top: 16, left: recommendedVerticalOffset, bottom: 0, right: -recommendedVerticalOffset)
        static let somethingButtonHeight: CGFloat = 40
        static let somethingButtonCornerRadius: CGFloat = 8
    }
    
    
    // MARK: - Private Properties
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.profileImageViewCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "AvatarProfile")
        
        return imageView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        label.text = "user_nickname"
        
        return label
    }()
    
    private lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var postsCounterView: CounterInfoView = {
        let view = CounterInfoView()
        view.setup(counter: 50, title: "Posts")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var followersCounterView: CounterInfoView = {
        let view = CounterInfoView()
        view.setup(counter: 200, title: "Followers")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var followingCounterView: CounterInfoView = {
        let view = CounterInfoView()
        view.setup(counter: 30, title: "Following")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var descriptionLabel: ExpandableLabel = {
        let label = ExpandableLabel(textForLabel: self.fullTextLabel,
                                    needNumberOfLines: 2,
                                    moreButtonFont: Constants.moreButtonFont,
                                    moreButtonColor: Constants.moreButtonColor,
                                    titleReadmore: "Readmore",
                                    trailingReadmore: "... ",
                                    titleReadless: "Readless",
                                    trailingReadless: "\n")
        label.font = Constants.descriptionFont
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var somethingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.somethingButtonCornerRadius
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    private let fullTextLabel = "On third line our text need be collapsed because we have ordinary text, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSelf()
    }

    
    // MARK: - Drawing view
    
    private func drawSelf() {
        self.view.addSubview(self.profileImageView)
        self.view.addSubview(self.nicknameLabel)
        
        self.profileInfoStackView.addArrangedSubview(self.postsCounterView)
        self.profileInfoStackView.addArrangedSubview(self.followersCounterView)
        self.profileInfoStackView.addArrangedSubview(self.followingCounterView)
        self.view.addSubview(self.profileInfoStackView)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.somethingButton)
        
        self.descriptionLabel.delegate = self
        
        let constraintsForProfileImageView = self.constraintsForProfileImageView()
        let constraintsForNicknameLabel = self.constraintsForNicknameLabel()
        let constraintsForProfileInfoStackView = self.constraintsForProfileInfoStackView()
        let constraintsForDescriptionLabel = self.constraintsForDescriptionLabel()
        let constraintsForSomethingButton = self.constraintsForSomethingButton()
        
        NSLayoutConstraint.activate(
            constraintsForProfileImageView +
            constraintsForNicknameLabel +
            constraintsForProfileInfoStackView +
            constraintsForDescriptionLabel +
            constraintsForSomethingButton
        )
    }
    
    private func constraintsForProfileImageView() -> [NSLayoutConstraint] {
        let topAnchor = self.profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.profileImageViewInset.top)
        let trailingAnchor = self.profileImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Constants.profileImageViewInset.right)
        let height = self.profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageViewSize)
        let width = self.profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageViewSize)
        
        return [
            topAnchor,
            trailingAnchor,
            height,
            width
        ]
    }
    
    private func constraintsForNicknameLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.nicknameLabelInset.top)
        let leadingAnchor = self.nicknameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.nicknameLabelInset.left)
        let trailingAnchor = self.nicknameLabel.trailingAnchor.constraint(equalTo: self.profileImageView.leadingAnchor, constant: Constants.nicknameLabelInset.right)
        let height = self.nicknameLabel.heightAnchor.constraint(equalToConstant: Constants.nicknameLabelHeight)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor,
            height
        ]
    }
    
    private func constraintsForProfileInfoStackView() -> [NSLayoutConstraint] {
        let topAnchor = self.profileInfoStackView.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: Constants.profileInfoStackInset.top)
        let leadingAnchor = self.profileInfoStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.profileInfoStackInset.left)
        let trailingAnchor = self.profileInfoStackView.trailingAnchor.constraint(equalTo: self.profileImageView.leadingAnchor, constant: Constants.profileInfoStackInset.right)
        let height = self.profileInfoStackView.heightAnchor.constraint(equalToConstant: Constants.profileInfoStackHeight)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor,
            height
        ]
    }
    
    private func constraintsForDescriptionLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.descriptionLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: Constants.descriptionLabelInset.top)
        let leadingAnchor = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.descriptionLabelInset.left)
        let trailingAnchor = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Constants.descriptionLabelInset.right)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor
        ]
    }
    
    private func constraintsForSomethingButton() -> [NSLayoutConstraint] {
        let topAnchor = self.somethingButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: Constants.somethingButtonInset.top)
        let leadingAnchor = self.somethingButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.somethingButtonInset.left)
        let trailingAnchor = self.somethingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Constants.somethingButtonInset.right)
        let heightAnchor = self.somethingButton.heightAnchor.constraint(equalToConstant: Constants.somethingButtonHeight)
        
        return [
            topAnchor,
            leadingAnchor,
            trailingAnchor,
            heightAnchor
        ]
    }
}

extension ViewController: ExpandableLabelDelegate {
    
    func didUpdateView(with durationAnimation: CGFloat) {
        UIView.animate(withDuration: durationAnimation) {
            self.descriptionLabel.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
}
