//
//  CaptureImageViewController.swift
//  SandstoneQuiz
//
//  Created by Rahul Murthy on 3/22/17.
//  Copyright © 2017 Rahul Murthy. All rights reserved.
//

import UIKit
import AVKit

class CaptureImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    // Our image, confirmed below
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var save: UIButton!
   
    /**
        send the photo off and segue after it. The photo has to be set.
    */
    @IBAction func calculate(_ sender: Any) {
        if ImageView.image == nil{
            let ac = UIAlertController(title: "No Photo!", message: "I need that photo!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        else{
            performSegue(withIdentifier: "ProcessImageSegue", sender: nil)
       }
        
    }
    
    // save the image for later
    @IBAction func save(_ sender: Any) {
        if ImageView.image == nil{
            let ac = UIAlertController(title: "No Photo!", message: "I need that photo to save it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)

        }
        else{
            UIImageWriteToSavedPhotosAlbum(ImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "The selected image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    
    /**
        Take a photo with a custom overlay
    */
    @IBAction func takePhoto(sender: UIButton) {
      
        // prepare overlay
        let customViewController = CustomOverlayViewController(
            nibName:"CustomOverlayViewController",
            bundle: nil
        )
        let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
        // refresh imagePickerController
        imagePicker = UIImagePickerController()
        // set view size and delegates
        customView.frame = self.imagePicker.view.frame
        // extra line probably!
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        
        // head to the camera, show the view once we get there
        present(imagePicker, animated: true, completion: {
            self.imagePicker.cameraOverlayView = customView
            
        })
       
      

    }
    
    /**
        load a photo from the camera roll
    */
    @IBAction func loadPhoto(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    /**
        set the selected/captured photo in the imageview
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        ImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
//        // notifications to hide the overlay when taking photos (it was bothering me)
//        let nc = NotificationCenter.default
//        nc.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object: <#T##Any?#>, queue: <#T##OperationQueue?#>, using: <#T##(Notification) -> Void#>)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProcessImageSegue"{
            if let vc = segue.destination as? ProcessImageViewController{
                vc.image = self.ImageView.image
            }
        }
        
        
        
        // Pass the selected object to the new view controller.
    }
    

}
