//
//  ViewController.swift
//  CustomControls
//
//  Created by Jeff Kang on 11/23/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func updateRating(_ ratingControl: CustomControl) {
        self.title = "User Rating: \(ratingControl.value) \(ratingControl.value > 1 ? "stars" : "star")"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "User Rating: 1 star"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
