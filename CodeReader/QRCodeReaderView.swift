//
//  QRCodeReaderView.swift
//  QRCodeReaderTest
//
//  Created by Ken Yurino on 2022/06/21.
//

import SwiftUI

struct QRCodeReaderView: UIViewControllerRepresentable {
  var caLayer: CALayer
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<QRCodeReaderView>) -> UIViewController {
    let viewController = UIViewController()
    viewController.view.layer.addSublayer(caLayer)
    caLayer.frame = viewController.view.layer.frame
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewController,
                              context: UIViewControllerRepresentableContext<QRCodeReaderView>) {
    caLayer.frame = uiViewController.view.layer.frame
  }
}
