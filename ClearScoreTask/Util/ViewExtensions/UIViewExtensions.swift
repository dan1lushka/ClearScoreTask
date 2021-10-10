//
//  UIViewExtensions.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 07/10/2021.
//

import UIKit

extension UIView {
  func makeCircular() {
    self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
    self.clipsToBounds = true
  }
}
