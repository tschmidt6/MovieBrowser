//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class SampleAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.loadViewIfNeeded()
        XCTAssert(vc.movies.isEmpty)
        
        let movie = Movie(id: 0, title: "Squid Game: Fireplace", release_date: "2024-12-12", popularity: 7.6, overview: "Come share a toast in the Front Man\'s lair — but tread carefully, for you’re playing with fire.", poster_path: "")
        vc.searchController?.onSearchResults?([movie])
        
        XCTAssert(vc.movies == [movie])
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 1, "Expected one row in the table view")
        let cell = vc.tableView.dataSource?.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieTableCell
        
        XCTAssert(cell?.title?.text == movie.title)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.loadViewIfNeeded()
        
        XCTAssert(vc.errorView?.isHidden == true)
        
        vc.searchController?.showError?(ServiceError.connectivity.errorDescription!)
        
        XCTAssert(vc.errorView?.isHidden == false)
        
        vc.searchController?.hideError?()
        
        XCTAssert(vc.errorView?.isHidden == true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
