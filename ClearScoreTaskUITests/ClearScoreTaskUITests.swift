//
//  ClearScoreTaskUITests.swift
//  ClearScoreTaskUITests
//
//  Created by Daniel Rybak on 05/10/2021.
//

import XCTest

class ClearScoreTaskUITests: XCTestCase {
  
  override func setUp() {
    continueAfterFailure = false
  }
  
  func testAppNavigatesToDetailsScreenWhenDataSuccessfullyFetchedAndScoreViewIsTapped() throws {
    let app = XCUIApplication()
    app.launch()
    app.staticTexts["Your credit score is "].tap()
    let debtInformationLabel = app.staticTexts["Debt Information"]
    
    XCTAssertTrue(debtInformationLabel.exists)
  }
  
  func testAppDoesNotNavigateToDetailsScreenWhenDataSuccessfullyFetchedAndTappedOutsideOfScoreView() throws {
    let app = XCUIApplication()
    app.launch()
    XCUIApplication().navigationBars["Dashboard"].staticTexts["Dashboard"].tap()
    let debtInformationLabel = app.staticTexts["Debt Information"]
    
    XCTAssertFalse(debtInformationLabel.exists)
  }
  
  func testAppShowsErrorInsteadOfScoreNumberWhenDataWasNotFetched() throws {
    let app = XCUIApplication()
    app.launchArguments = ["testing-Unsuccessful-response"]
    app.launch()
    
    let scoreLabel = app.staticTexts["Error"]
    XCTAssertTrue(scoreLabel.exists)
  }
  
  func testAppDoesNotNavigateToDetailsWhenDataWasNotFetched() throws {
    let app = XCUIApplication()
    app.launchArguments = ["testing-Unsuccessful-response"]
    app.launch()
    
    let scoreLabel = app.staticTexts["Error"]
    scoreLabel.tap()
    XCTAssertTrue(scoreLabel.exists)
    
    let debtInformationLabel = app.staticTexts["Debt Information"]
    XCTAssertFalse(debtInformationLabel.exists)
  }
  
}
