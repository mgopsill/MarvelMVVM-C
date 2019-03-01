//
//  RootCoordinator.swift
//  MarvelMVVM-C
//
//  Created by Mike Gopsill on 01/03/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import UIKit

protocol CharacterNavigationDelegate: class {
    func didSelect(character: MarvelCharacter?)
}

class RootCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    var charactersViewController: CharactersTableViewController {
        let service = CharacterService()
        let viewModel = CharactersViewModel(characterService: service)
        return CharactersTableViewController(viewModel: viewModel)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = charactersViewController
        viewController.navigationDelegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RootCoordinator: CharacterNavigationDelegate {
    func didSelect(character: MarvelCharacter?) {
        guard let character = character else { return }
        let detailsViewController = CharacterDetailsViewController(character: character)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
