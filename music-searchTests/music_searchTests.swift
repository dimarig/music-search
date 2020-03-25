import XCTest
import AwaitKit
import UIKit
import Foundation
import RxSwift
@testable import music_search

class music_searchTests: XCTestCase {

    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsing() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let response = """
{
    "resultCount": 2,
    "results": [
        {
            "artistName": "David Guetta",
            "collectionName": "Nothing But the Beat",
            "trackName": "Titanium (feat. Sia)",
            "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music5/v4/8f/80/b5/8f80b5c1-b6e2-0c93-b5e5-b83031dd4e60/source/100x100bb.jpg",
            "trackExplicitness": "notExplicit",
        },
        {
            "artistName": "Cardi B, Bad Bunny & J Balvin",
            "trackName": "I Like It",
            "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/30/f9/52/30f952dd-d4cd-a9be-907c-d66bf19bfe23/source/100x100bb.jpg",
            "trackExplicitness": "explicit",
        }
    ]
}
"""
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode(MusicListDTO.self, from: response.data(using: .utf8) ?? Data())
            XCTAssert(true)
        }
        catch {
            XCTFail()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        let model = MusicListModel()
        self.measure {
            _ = model.loadResults(query: "Cardi B")
        }
    }
    
    func testEmpty() throws {
        let model = MusicListModel()
        _ = model.loadResults(query: "")
        XCTAssertEqual(model.searchResultList.value.count, 0)
    }
    
    func testImageUrl() throws {
        let model = MusicListModel()
        _ = model.searchResultList.asObservable().bind { result in
            if model.searchResultList.value.count != 0 {
                if let imageUrl = URL(string: model.searchResultList.value.first?.artworkUrl100 ?? "") {
                    XCTAssert(true)
                } else {
                    print(model.searchResultList.value.first?.artworkUrl100)
                    XCTFail()
                }
            }
        }
        
        _ = model.loadResults(query: "David Guetta")
        
    }

}
