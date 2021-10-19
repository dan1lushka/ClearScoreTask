//
//  ClearScoreTaskTests.swift
//  ClearScoreTaskTests
//
//  Created by Daniel Rybak on 05/10/2021.
//

import XCTest
@testable import ClearScoreTask

class ClearScoreTaskTests: XCTestCase {
  
  var homeVC: HomeVCProtocol = HomeVC()
  var networkService: NetworkServiceProtocol!
  
  func testErrorFetchingScoreInfoDoesNotChangeScoreFromInitialValue() throws {
    networkService = networkServiceMock(isSuccessful: false)
    homeVC.networkService = networkService
    
    let expectation = self.expectation(description: "creditInfo")
    
    Task {
      await homeVC.fetchCreditInfo()
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertTrue(homeVC.score == 0)
  }
  
  func testSuccessfulFetchingChangesScoreToExpectedNumber() throws {
    networkService = networkServiceMock(isSuccessful: true)
    homeVC.networkService = networkService

    let expectation = self.expectation(description: "creditInfo")
    
    Task {
      await homeVC.fetchCreditInfo()
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)

    XCTAssertTrue(homeVC.score == 333)
  }
}

class networkServiceMock: NetworkServiceProtocol {
  
  var isSuccessful: Bool
  
  init(isSuccessful: Bool) {
    self.isSuccessful = isSuccessful
  }
  
  func performNetworkCall<T>(urlString: String, objectType: T.Type) async -> T? where T : Decodable, T : Encodable {
    if isSuccessful {
      return CreditInfo(accountIDVStatus: "", creditReportInfo:
                          CreditReportInfo(score: 333, scoreBand: 1, clientRef: "", status: "", maxScoreValue: 1, minScoreValue: 1, monthsSinceLastDefaulted: 1, hasEverDefaulted: true, monthsSinceLastDelinquent: 1, hasEverBeenDelinquent: true, percentageCreditUsed: 2, percentageCreditUsedDirectionFlag: 2, changedScore: 2, currentShortTermDebt: 2, currentShortTermNonPromotionalDebt: 2, currentShortTermCreditLimit: 2, currentShortTermCreditUtilisation: 2, changeInShortTermDebt: 2, currentLongTermDebt: 2, currentLongTermNonPromotionalDebt: 2, changeInLongTermDebt: 2, numPositiveScoreFactors: 2, numNegativeScoreFactors: 2, equifaxScoreBand: 2, equifaxScoreBandDescription: "", daysUntilNextReport: 2), dashboardStatus: "", personaType: "",
                        coachingSummary: CoachingSummary(activeTodo: true, activeChat: true, numberOfTodoItems: 2, numberOfCompletedTodoItems: 2, selected: true)) as? T
    } else {
      return nil
    }
  }
}
