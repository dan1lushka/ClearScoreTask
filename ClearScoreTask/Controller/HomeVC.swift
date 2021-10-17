//
//  ViewController.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 05/10/2021.
//

import UIKit

class HomeVC: UIViewController {
  
  @IBOutlet weak var scoreView: UIView!
  @IBOutlet weak var scoreLabel: AnimatedLabel!
  
  let animationStartData = Date()
  let shapeLayer = CAShapeLayer()
  let scoreViewProgressStorke: CGFloat = 5

  var score: Double = 0.0
  var minimumScore: Double = 0
  var maximumScore: Double = 700.0
  var creditInfo: CreditInfo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    changeScoreLabelValue()
  }
  
  
  func changeScoreLabelValue() {
    
    let networkService = NetworkService()
    let stringURL = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    
    networkService.performNetworkCall(urlString: stringURL, objectType: CreditInfo.self) { creditInfo in
      if let creditInfo = creditInfo {
        
        self.score = Double(creditInfo.creditReportInfo.score)
        
        self.configureScoreView()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(self.updateScoreLabel))
        displayLink.add(to: .main, forMode: .default)
        
        
        
      } else {
        self.scoreLabel.text = "Error"
      }
    }
  }
  
  @objc func updateScoreLabel() {
    
    let animationDuration: Double = 1.9
    let now = Date()
    let timeElapsed = now.timeIntervalSince(animationStartData)
    
    if timeElapsed > animationDuration {
      let intScore = Int(score)
      self.scoreLabel.text = String(intScore)
    } else {
      let percentage = timeElapsed / animationDuration
      let value = percentage * (score - minimumScore)
      let intValue = Int(value)
      self.scoreLabel.text = String(intValue)
    }
  }
  
  // Mark: Score View handling
  func configureScoreView() {
    
    scoreView.makeCircular()
    scoreView.layer.borderColor = getBorderColor()
    scoreView.layer.borderWidth = 1
    
    let circularPath = UIBezierPath(
                                    arcCenter: scoreView.center,
                                    radius: min(scoreView.frame.size.height, scoreView.frame.size.width) / 2.0 - scoreViewProgressStorke,
                                    startAngle: -.pi / 2,
                                    endAngle: .pi * 1.5,
                                    clockwise: true
                                    )
    shapeLayer.path = circularPath.cgPath
    shapeLayer.lineWidth = scoreViewProgressStorke
    shapeLayer.strokeColor = UIColor.blue.cgColor
    shapeLayer.fillMode = .forwards
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeEnd = 0
    shapeLayer.lineCap = .round
    view.layer.addSublayer(shapeLayer)
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let scorePercentage = score / maximumScore
    print(scorePercentage)
    basicAnimation.toValue = scorePercentage
    basicAnimation.duration = 1
    basicAnimation.fillMode = .forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "basic")
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
