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
    scoreView.makeCircular()
    
    scoreView.layer.borderColor = getBorderColor()
    scoreView.layer.borderWidth = 1
    
    scoreLabel.text = "327"
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    scoreView.layer.borderColor = getBorderColor()
  }
  
  func getBorderColor() -> CGColor {
    return self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
  }
}
