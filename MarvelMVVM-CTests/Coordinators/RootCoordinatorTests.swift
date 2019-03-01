//
//  RootCoordinatorTests.swift
//  MarvelMVVM-CTests
//
//  Created by Mike Gopsill on 01/03/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import XCTest

@testable import MarvelMVVM_C

class RootCoordinatorTests: XCTestCase {
    
    var subject: RootCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        subject = RootCoordinator(navigationController: navigationController)
    }

    override func tearDown() {
        subject = nil
    }

    func test_Start_PresentsCharactersTableViewController() {
        subject.start()
        let correctViewController = navigationController.topViewController as? CharactersTableViewController
        XCTAssertNotNil(correctViewController)
    }
    
    func test_DidSelectCalledWithValidCharacter_PresentsDetailsVC() {
        let mockCharacter = MarvelCharacter(name: "name", description: "description", thumbnail: Thumbnail(path: "path", thumbnailExtension: .jpg))
        subject.didSelect(character: mockCharacter)
        let correctViewController = navigationController.topViewController as? CharacterDetailsViewController
        XCTAssertNotNil(correctViewController)
    }
    
    
    func test_DidSelectCalledWithNilCharacter_DoesNothing() {
        subject.didSelect(character: nil)
        let correctViewController = navigationController.topViewController as? CharacterDetailsViewController
        XCTAssertNil(correctViewController)
    }
}
