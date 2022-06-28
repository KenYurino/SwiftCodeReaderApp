//
//  ContentView.swift
//  CodeReader
//
//  Created by Ken Yurino on 2022/06/27.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var codeReader = CodeReader()
  
  var body: some View {
    
    NavigationView {
      List {
        ForEach(codeReader.decodeData) { decode in
          Button(action: {
          }) {
              Text(decode.decodeText)
          }
        }
      }
      .navigationBarItems(trailing: Button(action: {
        codeReader.isShowSheet = true
        codeReader.startSession()
      }) {
        Text("Camera")
      })
    }
    .sheet(isPresented: $codeReader.isShowSheet) {
      CodeReaderView(caLayer: codeReader.previewLayer)
    }
  }
  func prepare() {
    codeReader.isShowSheet = false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
