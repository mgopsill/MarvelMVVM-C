//
//  CharacterServiceTests.swift
//  MarvelMVVM-CTests
//
//  Created by Mike Gopsill on 23/01/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import XCTest

@testable import MarvelMVVM_C

class CharacterServiceTests: XCTestCase {

    var subject: CharacterService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        mockNetworkManager = MockNetworkManager()
        subject = CharacterService(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func test_FetchCharactersSucceedsReturnsCharacterResponseModel() {
        let data = CharacterServiceTests.mockData
        
        mockNetworkManager.data = data
        var result: Result<CharacterResponseModel>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchCharacters { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
   
        XCTAssertNotNil(result?.value)
        XCTAssertNil(result?.error)
    }
    
    func test_FetchCharactersGetsIncorrectDataDoesSomething() {
        let incorrectData = Data(bytes: [0,1,2,3])
        mockNetworkManager.data = incorrectData
        mockNetworkManager.error = TestError.test

        var result: Result<CharacterResponseModel>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchCharacters { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

        XCTAssertNotNil(result?.error)
        XCTAssertNil(result?.value)
    }
    
    func test_FetchCharactersFailsReturnsNil() {
        mockNetworkManager.data = nil
        mockNetworkManager.error = TestError.test
        
        var result: Result<CharacterResponseModel>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchCharacters { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertNotNil(result?.error)
        XCTAssertNil(result?.value)
    }
}

class MockNetworkManager: NetworkManaging {
    
    var data: Data?
    var error: Error?
    
    var fetchCalled: Bool = false
    func fetch(request: URLRequest, completeOnMainThread: Bool, completion: @escaping ServiceCompletion) -> URLSessionDataTaskProtocol {
        fetchCalled = true
        
        let data = self.data
        let error = self.error
        
        let dataTask = MockURLSessionDataTask {
            completion(data, nil, error)
        }
        dataTask.resume()
        return dataTask
    }
}

enum TestError: Error {
    case test
}

extension CharacterServiceTests {
    static var mockData: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "characters", ofType: "json")!
        return FileManager().contents(atPath: path)!
    }
}
