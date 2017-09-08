//
//  ShotsProviderTests.swift
//  ShotsProviderTests
//
//  Created by Ivan Lazarev on 05.09.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import JetDribble

class ShotsProviderTests: XCTestCase {
    
    var defaultSession: DHURLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "shots", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let url = URL(string: Config.url)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        defaultSession = sessionMock
        ShotsProvider.flushDatabase()
    }
    
    override func tearDown() {
        defaultSession = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Fake URLSession with DHURLSession protocol and stubs
    func test_SaveShots_GetShotsCount() {
        // given
        let promise = expectation(description: "Status code: 200")
        // when
        XCTAssertEqual(ShotsProvider.getShotsCount(), 0, "getShotsCount should be empty before the data task runs")
        let url = URL(string: Config.url)
        let dataTask = defaultSession.dataTask(with: url!) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let json = JSON(data: data!).arrayValue
                    let shots = json.map{
                        return Shot.init(json: $0)
                    }
                    ShotsProvider.saveShots(shots){
                        promise.fulfill()
                    }
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        // then
        XCTAssertEqual(ShotsProvider.getShotsCount(), 4, "Didn't parse 4 (1 is animated shot) items from fake response")
    }
    
}
