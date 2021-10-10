//
//  ViewController.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 05/10/2021.
//

import UIKit

class HomeVC: UIViewController {

  @IBOutlet weak var scoreView: UIView!
  @IBOutlet weak var scoreLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureScoreLabel()
    configureScoreView()
    configureNavBar()
  }
  
  // Mark: Score label handling
  func configureScoreLabel() {
    let networkService = NetworkService()
    let stringURL = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    
    networkService.performNetworkCall(urlString: stringURL, objectType: CreditInfo.self) { creditInfo in
      self.changeScoreLabelValue(creditInfo: creditInfo)
    }
  }
  
  func changeScoreLabelValue(creditInfo: CreditInfo?) {
    if let creditInfo = creditInfo {
      let score = creditInfo.creditReportInfo.score
      self.scoreLabel.text = String(score)
    } else {
      self.scoreLabel.text = "Error"
    }
  }
  
  // Mark: Score View handling
  func configureScoreView() {
    scoreView.makeCircular()
    scoreView.layer.borderColor = getBorderColor()
    scoreView.layer.borderWidth = 1
  }
  
  // Mark: Navigation bar handling
  func configureNavBar() {
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
  }
  
  // Mark: Dark mode handling
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    scoreView.layer.borderColor = getBorderColor()
  }
  
  func getBorderColor() -> CGColor {
    return self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
  }
}
