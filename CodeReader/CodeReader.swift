//
//  CodeReader.swift
//  CodeReaderTest
//
//  Created by Ken Yurino on 2022/06/21.
//

import UIKit
import AVFoundation

class CodeReader: NSObject,
                 AVCaptureMetadataOutputObjectsDelegate,
                 ObservableObject {
  
  @Published var isShowSheet: Bool = false
  @Published var decodeData = [DecodeData(decodeText: "")]
  
  var previewLayer: CALayer!
  var captureSession = AVCaptureSession()
  
  private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                    AVMetadataObject.ObjectType.code39,
                                    AVMetadataObject.ObjectType.code39Mod43,
                                    AVMetadataObject.ObjectType.code93,
                                    AVMetadataObject.ObjectType.code128,
                                    AVMetadataObject.ObjectType.ean8,
                                    AVMetadataObject.ObjectType.ean13,
                                    AVMetadataObject.ObjectType.aztec,
                                    AVMetadataObject.ObjectType.pdf417,
                                    AVMetadataObject.ObjectType.itf14,
                                    AVMetadataObject.ObjectType.dataMatrix,
                                    AVMetadataObject.ObjectType.interleaved2of5,
                                    AVMetadataObject.ObjectType.qr]
  
  override init() {
    super.init()
    prepare()
  }
  
  private func prepare() {
    guard let captureDevice = AVCaptureDevice.default(
      .builtInWideAngleCamera, for: .video, position: .back) else {
      print("Failed to get the camera device")
      return
    }
    
    do {
      // Get an instance of the AVCaptureDeviceInput class using the previous device object
      let input = try AVCaptureDeviceInput(device: captureDevice)
      
      // Set the input device on the capture session
      captureSession.addInput(input)
      
      // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session
      let captureMetadataOutput = AVCaptureMetadataOutput()
      captureSession.addOutput(captureMetadataOutput)
      
      // Set delegate and use the default dispatch queue to execute the call back
      captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      // captureMetadataOutput.metadataObjectTypes = [                                　　　.ObjectType.qr]
      captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
      
      // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer
      previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      
      // Start video capture
      //      captureSession.startRunning()
      
    } catch {
      // If any error occurs, simply print it out and don't continue anymore
      print(error)
      return
    }
  }
  
  func startSession() {
    if captureSession.isRunning { return }
    captureSession.startRunning()
  }
  
  func endSession() {
    if !captureSession.isRunning { return }
    captureSession.stopRunning()
  }
}


extension CodeReader {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    // Check if the metadataObjects array is not nil and it contains at least one object
    if metadataObjects.count == 0 {
      return
    }
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    if supportedCodeTypes.contains(metadataObj.type) {
      
      if metadataObj.stringValue != nil {
        print(metadataObj.stringValue)
        endSession()
        isShowSheet = false
        
        if decodeData.first?.decodeText.isEmpty == true {
          decodeData.remove(at: 0)
        }
        decodeData.append(DecodeData(decodeText: metadataObj.stringValue!))
      }
    }
  }
}

