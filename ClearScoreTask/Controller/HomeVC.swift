//
//  ViewController.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 05/10/2021.
//

import UIKit

class HomeVC: UIViewController {
  
  // MARK: Properties
  @IBOutlet weak var scoreView: UIView!
  @IBOutlet weak var scoreLabel: UILabel!
  
  let animationStartData = Date()
  let shapeLayer = CAShapeLayer()
  let scoreViewProgressStorke: CGFloat = 5
  
  var score = 0
  var creditInfo: CreditInfo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavBar()
    fetchCreditInfo()
  }
}

// MARK: dark mode handling
extension HomeVC {
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    scoreView.layer.borderColor = getBorderColor()
  }
  
  private func getBorderColor() -> CGColor {
    return self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
  }
}

// MARK: navigation bar handling
extension HomeVC {
  private func configureNavBar() {
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
  }
}

// MARK: api fetching handling
extension HomeVC {
  func fetchCreditInfo() {
    
    let networkService = NetworkService()
    let stringURL = K.creditInfoURLString
    
    Task.init {
      let creditInfo = await networkService.performNetworkCall(urlString: stringURL, objectType: CreditInfo.self)
      if let creditInfo = creditInfo {
        self.creditInfo = creditInfo
        self.score = creditInfo.creditReportInfo.score
        self.configureScoreLabel()
        self.configureScoreView()
      } else {
        self.scoreLabel.text = "Error"
      }
    }
  }
}

// MARK: scoreLabel handling
extension HomeVC {
  func configureScoreLabel() {
    let displayLink = CADisplayLink(target: self, selector: #selector(self.updateScoreLabel))
    displayLink.add(to: .main, forMode: .default)
  }
  
  @objc func updateScoreLabel() {
    
    let animationDuration: Double = 1.9
    let now = Date()
    let timeElapsed = now.timeIntervalSince(animationStartData)
    
    if timeElapsed > animationDuration {
      self.scoreLabel.text = String(score)
    } else {
      let percentage = timeElapsed / animationDuration
      let minimumScore = Double(creditInfo?.creditReportInfo.minScoreValue ?? 0)
      let value = percentage * (Double(score) - minimumScore)
      let intValue = Int(value)
      self.scoreLabel.text = String(intValue)
    }
  }
}

// MARK: scoreView handling
extension HomeVC {
  private func configureScoreView() {
    
    scoreView.makeCircular()
    scoreView.layer.borderColor = getBorderColor()
    scoreView.layer.borderWidth = 1
    
    addCircularProggressBar()
    animateProggressBar()
    
    scoreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToDetailsView)))
  }
  
  private func addCircularProggressBar() {
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
  }
  
  private func animateProggressBar() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let maxScore = creditInfo?.creditReportInfo.maxScoreValue
    let scorePercentage = Double(score) / Double(maxScore ?? 700)
    basicAnimation.toValue = scorePercentage
    basicAnimation.duration = 1
    basicAnimation.fillMode = .forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "basic")
  }
}

// MARK: navigation handling
extension HomeVC {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let detailsVC = segue.destination as? DetailsVC else { return }
    detailsVC.creditInfo = self.creditInfo
  }
  
  @objc func navigateToDetailsView() {
    self.performSegue(withIdentifier: K.homeToDetailsSegueString, sender: self)
  }
}
