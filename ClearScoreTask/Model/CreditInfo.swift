//
//  CreditInfo.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 07/10/2021.
//

import Foundation

// MARK: - CreditInfo
struct CreditInfo {
  let accountIDVStatus: String
  let creditReportInfo: CreditReportInfo
  let dashboardStatus, personaType: String
  let coachingSummary: CoachingSummary
  let augmentedCreditScore: NSNull
}

// MARK: - CoachingSummary
struct CoachingSummary {
  let activeTodo, activeChat: Bool
  let numberOfTodoItems, numberOfCompletedTodoItems: Int
  let selected: Bool
}

// MARK: - CreditReportInfo
struct CreditReportInfo {
  let score, scoreBand: Int
  let clientRef, status: String
  let maxScoreValue, minScoreValue, monthsSinceLastDefaulted: Int
  let hasEverDefaulted: Bool
  let monthsSinceLastDelinquent: Int
  let hasEverBeenDelinquent: Bool
  let percentageCreditUsed, percentageCreditUsedDirectionFlag, changedScore, currentShortTermDebt: Int
  let currentShortTermNonPromotionalDebt, currentShortTermCreditLimit, currentShortTermCreditUtilisation, changeInShortTermDebt: Int
  let currentLongTermDebt, currentLongTermNonPromotionalDebt: Int
  let currentLongTermCreditLimit, currentLongTermCreditUtilisation: NSNull
  let changeInLongTermDebt, numPositiveScoreFactors, numNegativeScoreFactors, equifaxScoreBand: Int
  let equifaxScoreBandDescription: String
  let daysUntilNextReport: Int
}

