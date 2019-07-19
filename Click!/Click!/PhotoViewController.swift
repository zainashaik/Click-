//
//  PhotoViewController.swift
//  Click!
//
//  Created by Zaina Shaik on 7/12/19.
//  Copyright © 2019 Zaina Shaik. All rights reserved.
//

import UIKit
import CoreImage

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
     @IBAction func filter1(_ sender: Any) {
        let context = CIContext()
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: myImageView.image!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale),
                               orientation: .right)
        myImageView.image = newImage
     }
    
     @IBAction func filter2(_ sender: Any) {
        let context = CIContext()
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(25, forKey: kCIInputWidthKey)
        
        let image = CIImage(image: myImageView.image!)
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale),
                               orientation: .right)
        myImageView.image = newImage
        
     }
    
     @IBAction func filter3(_ sender: Any) {
        let context = CIContext()
        
        let filter = CIFilter(name: "CIPhotoEffectInstant")!
        
        let image = CIImage(image: myImageView.image!)
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale),
                               orientation: .right)
        myImageView.image = newImage
     }
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        saveImage("test.png")
    }
    
    func saveImage(_ imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,
        true)[0] as NSString).appendingPathComponent(imageName)
        let image = myImageView.image!
        let imageData = image.pngData()
        fileManager.createFile(atPath: imagePath as String, contents: imageData, attributes: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        myImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    
    
}


