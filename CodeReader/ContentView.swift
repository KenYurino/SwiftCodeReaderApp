//
//  ContentView.swift
//  CodeReader
//
//  Created by Ken Yurino on 2022/06/27.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var qrScanner = QRScanner()
  
  var body: some View {
    
    NavigationView {
      List {
        ForEach(qrScanner.decodeData) { decode in
          Button(action: {
          }) {
              Text(decode.decodeText)
          }
        }
      }
      .navigationBarItems(trailing: Button(action: {
        qrScanner.isShowSheet = true
        qrScanner.startSession()
      }) {
        Text("Camera")
      })
    }
    .sheet(isPresented: $qrScanner.isShowSheet) {
      QRCodeReaderView(caLayer: qrScanner.previewLayer)
    }
  }
  func prepare() {
    qrScanner.isShowSheet = false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
