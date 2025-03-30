//
//  ResultViewController.swift
//  Asssignment3
//
//  Created by Ishika Bhatia on 2025-03-28.
//

import UIKit

class ResultViewController: UIViewController {
    
    var finalScore: Int?
    var totalQuestions: Int?


    override func viewDidLoad() {
        super.viewDidLoad()

        if let score = finalScore, let total = totalQuestions {
            scoreLabel.text = "You scored \(score) out of \(total)"
        }
    }
    
    
    @IBAction func btnDone(_ sender: Any) {
        self.dismiss(animated: true) {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
    }
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
