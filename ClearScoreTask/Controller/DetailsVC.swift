//
//  DetailsVC.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 17/10/2021.
//

import UIKit

class DetailsVC: UIViewController {
  
  // MARK: Container views
  @IBOutlet weak var summaryView: UIView!
  @IBOutlet weak var DebtInfoView: UIView!
  
  // MARK: Summary labels
  @IBOutlet weak var positiveScoreFactorsLabel: UILabel!
  @IBOutlet weak var negativeScoreFactorsLabel: UILabel!
  @IBOutlet weak var scoreBandLabel: UILabel!
  @IBOutlet weak var scoreBandDescriptionLabel: UILabel!
  @IBOutlet weak var daysUntilNextReportLabel: UILabel!
  
  // MARK: Debt information labels
  @IBOutlet weak var currentShortTermDebtLabel: UILabel!
  @IBOutlet weak var currentLongTermDebtLabel: UILabel!
  @IBOutlet weak var currentShortTermCreditLimitLabel: UILabel!
  @IBOutlet weak var currentShortTermCreditUtilisationLabel: UILabel!
  @IBOutlet weak var percentageCreditUsedLabel: UILabel!
  
  var creditInfo: CreditInfo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let creditReportInfo = creditInfo?.creditReportInfo else { return }
    
    configureContainerViews()
    configureSummaryLabels(creditReportInfo: creditReportInfo)
    configureDebtInfoLabels(creditReportInfo: creditReportInfo)
    
  }
}

// MARK: Configure Views
extension DetailsVC {
  private func configureContainerViews() {
    summaryView.layer.cornerRadius = 25
    DebtInfoView.layer.cornerRadius = 25
  }
  
  private func configureSummaryLabels(creditReportInfo: CreditReportInfo) {
    positiveScoreFactorsLabel.text = "Positive score factors: \(creditReportInfo.numPositiveScoreFactors)"
    negativeScoreFactorsLabel.text = "Negative score factors: \(creditReportInfo.numNegativeScoreFactors)"
    scoreBandLabel.text = "Score Band: \(creditReportInfo.scoreBand)"
    scoreBandDescriptionLabel.text = "Score Band: \(creditReportInfo.equifaxScoreBandDescription)"
    daysUntilNextReportLabel.text = "Days until next report: \(creditReportInfo.daysUntilNextReport)"
  }
  
  private func configureDebtInfoLabels(creditReportInfo: CreditReportInfo) {
    currentShortTermDebtLabel.text = "Current short term debt: £\(creditReportInfo.currentShortTermDebt)"
    currentLongTermDebtLabel.text = "Current long term debt: £\(creditReportInfo.currentLongTermDebt)"
    currentShortTermCreditLimitLabel.text = "Current short term credit limit: £\(creditReportInfo.currentShortTermCreditLimit)"
    currentShortTermCreditUtilisationLabel.text = "Current short term credit utilisation: \(creditReportInfo.currentShortTermCreditUtilisation)%"
    percentageCreditUsedLabel.text = "Percentage of credit used: \(creditReportInfo.percentageCreditUsed)%"
  }
}
