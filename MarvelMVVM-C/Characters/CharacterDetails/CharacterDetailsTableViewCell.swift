//
//  CharacterDetailsTableViewCell.swift
//  MarvelMVVM-C
//
//  Created by Mike Gopsill on 28/02/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import UIKit

class CharacterDetailsTableViewCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    private var characterDescriptionURL: Foundation.URL?
    
    private let nameLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    private let characterImageView: UIImageView = UIImageView()
    private let button = UIButton()
    
    static let reuseIdentifier = "CharacterDetails"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(characterImageView)
        contentView.addSubview(button)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.numberOfLines = 0
        characterImageView.contentMode = .scaleAspectFit
        button.setTitle("Go to Website", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            let constraints:[NSLayoutConstraint] = [
                characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
                characterImageView.widthAnchor.constraint(equalToConstant: 200.0),
                characterImageView.heightAnchor.constraint(equalToConstant: 200.0),
                nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 30.0),
                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
                descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
                button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50.0),
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            didUpdateConstraints = true
        }
        super.updateConstraints()
    }
    
    func update(with character: MarvelCharacter, imageService: CharacterImageService = CharacterImageService()) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description == "" ? "No Description Provided" : character.description
        characterDescriptionURL = character.descriptionURL
        imageService.fetchImage(request: URLRequest(url: character.imageURL!)) { [weak self] (image, error) in
            guard let image = image else { return }
            self?.characterImageView.image = image
        }
        updateConstraints()
    }
    
    @objc func buttonTapped() {
        guard let url = characterDescriptionURL else { return }
        UIApplication.shared.open(url)
    }
}
