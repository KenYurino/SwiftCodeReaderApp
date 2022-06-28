//
//  SwiftUIView.swift
//  CodeReader
//
//  Created by Ken Yurino on 2022/06/28.
//

import SwiftUI

struct DecodeData: Identifiable, Equatable {
  let id = UUID()
  var decodeText: String
  
  init(decodeText: String) {
    self.decodeText = decodeText
  }
}
