//
//  CaptureImageViewController.swift
//  SandstoneQuiz
//
//  Created by Rahul Murthy on 3/22/17.
//  Copyright © 2017 Rahul Murthy. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Our image, confirmed below
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var save: UIButton!
   
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
    
    @IBAction func takePhoto(sender: UIButton) {
        
        //customView stuff
        let customViewController = CustomOverlayViewController(
            nibName:"CustomOverlayViewController",
            bundle: nil
        )
        let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
        
        imagePicker =  UIImagePickerController()
        
        customView.frame = self.imagePicker.view.frame
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        //imagePicker.cameraOverlayView
        
        present(imagePicker, animated: true, completion: {
            self.imagePicker.cameraOverlayView = customView
        })
      

    }
    
    @IBAction func loadPhoto(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        ImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
       
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "ProcessImageSegue"{
            if let vc = segue.destination as? ProcessImageViewController{
                vc.image = self.ImageView.image
            }
        }
        
        
        
        // Pass the selected object to the new view controller.
    }
    

}
