//
//  CodeReaderView.swift
//  CodeReaderTest
//
//  Created by Ken Yurino on 2022/06/21.
//

import SwiftUI

struct CodeReaderView: UIViewControllerRepresentable {
  var caLayer: CALayer
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<CodeReaderView>) -> UIViewController {
    let viewController = UIViewController()
    viewController.view.layer.addSublayer(caLayer)
    caLayer.frame = viewController.view.layer.frame
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewController,
                              context: UIViewControllerRepresentableContext<CodeReaderView>) {
    caLayer.frame = uiViewController.view.layer.frame
  }
}
