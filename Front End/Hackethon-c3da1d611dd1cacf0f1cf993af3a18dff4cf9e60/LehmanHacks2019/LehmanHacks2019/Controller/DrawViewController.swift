//
//  ViewController.swift
//  LehmanHacks2019
//
//  Created by Sabri Sönmez on 11/15/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit
import Vision

class DrawViewController: UIViewController {
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var name = String()
    
    
    var requests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVision()
        
        NotificationCenter.default.addObserver(self, selector: #selector(helloReceived), name: NSNotification.Name("hello"), object: nil)
        
        questionLabel.text = "Hi \(name)! Can You Find the Missing Number?"
        
    }
    
    
    //Calling a function using #selector
    @objc private func helloReceived() {
        recognizeDrawing()
    }
    func setupVision() {
        // load MNIST model for the use with the Vision framework
        guard let visionModel = try? VNCoreMLModel(for: MNISTClassifier().model) else {fatalError("can not load Vision ML model")}
        
        // create a classification request and tell it to call handleClassification once its done
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        
        self.requests = [classificationRequest] // assigns the classificationRequest to the global requests array
        
    }
    
    func handleClassification (request:VNRequest, error:Error?) {
        guard let observations = request.results else {print("no results"); return}
        
        // process the obvservations
        let classifications = observations
            .compactMap({$0 as? VNClassificationObservation}) // cast all elements to VNClassificationObservation objects
            .filter({$0.confidence > 0.8}) // only choose observations with a confidence of more than 80%
            .map({$0.identifier}) // only choose the identifier string to be placed into the classifications array
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
             self.digitLabel.text = classifications.first // update the UI with the classification
            if(self.digitLabel.text == "5"){
            
                self.performSegue(withIdentifier: "finalSegue", sender: nil)
            }else{
                self.digitLabel.text = "Try Again!"
            }
        })
        
    }
    
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func recognizeBtnPressed(_ sender: Any)
    {
       recognizeDrawing()
    }
    
    // scales any UIImage to a desired target size
    func scaleImage (image:UIImage, toSize size:CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recognizeDrawing()
    {
        let image = UIImage(view: canvasView) // get UIImage from CanvasView
        let scaledImage = scaleImage(image: image, toSize: CGSize(width: 28, height: 28)) // scale the image to the required size of 28x28 for better recognition results
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaledImage.cgImage!, options: [:]) // create a handler that should perform the vision request
        
        do {
            try imageRequestHandler.perform(self.requests)
        }catch{
            print(error)
        }
    }
   
    
}

