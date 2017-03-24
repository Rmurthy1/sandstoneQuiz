//
//  ProcessImageViewController.swift
//  SandstoneQuiz
//
//  Created by Rahul Murthy on 3/23/17.
//  Copyright © 2017 Rahul Murthy. All rights reserved.
//

import UIKit

class ProcessImageViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    var image:UIImage?
    
    @IBOutlet weak var label: UILabel!
    @IBAction func sliderValueUpdate(_ sender: UISlider) {
        
        
        // calculate the number of pixels from the height of the slider
        // (% of slider * height of slider * scale value)
        let displayVal = (sender.value/100.0) * Float(sender.frame.height * UIScreen.main.scale)
        label.text = "\(displayVal) Pixels"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the image
        ImageView.image = image
      
      
        // Flip the slider vertically
        self.slider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
