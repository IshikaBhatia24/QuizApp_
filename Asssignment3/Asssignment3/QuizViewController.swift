//
//  QuizViewController.swift
//  Asssignment3
//
//  Created by Ishika on 2025-03-22.
//

import UIKit

class QuizViewController: UIViewController {

    
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var btnOption1: UIButton!
    
    @IBOutlet weak var btnOption2: UIButton!
    
    @IBOutlet weak var btnOption3: UIButton!
    
    @IBOutlet weak var btnOption4: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
        var questions: [Question] = []
        var currentQuestionIndex: Int = 0
        var correctAnswersCount: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = ((UIApplication.shared.delegate) as! AppDelegate).myModel.questionsList
        displayCurrentQuestion()
        
        progressbar.progress = 0.0
    }
    
    func displayCurrentQuestion() {
        print("current index \(currentQuestionIndex)")
        print("no of question \(questions.count)")
        
            if currentQuestionIndex < questions.count {
                let question = questions[currentQuestionIndex]
                labelQuestion.text = question.question
                
                let shuffledChoices = (question.choices + [question.correct_answer!]).shuffled()
                
                btnOption1.setTitle(shuffledChoices.indices.contains(0) ? shuffledChoices[0] : "", for: .normal)
                btnOption2.setTitle(shuffledChoices.indices.contains(1) ? shuffledChoices[1] : "", for: .normal)
                btnOption3.setTitle(shuffledChoices.indices.contains(2) ? shuffledChoices[2] : "", for: .normal)
                btnOption4.setTitle(shuffledChoices.indices.contains(3) ? shuffledChoices[3] : "", for: .normal)
                
                resetButtonStates()
                
              
                btnNext.isHidden = question.userAnswers == nil
                
                let progress = Float(currentQuestionIndex) / Float(questions.count)
                        progressbar.setProgress(progress, animated: true)
                btnPrevious.isHidden = currentQuestionIndex == 0
                
                btnSubmit.isHidden = currentQuestionIndex != questions.count - 1 || questions[currentQuestionIndex].userAnswers == nil

            
            }
        
        if(currentQuestionIndex == questions.count + 1){
            btnSubmit.isHidden = false
            btnNext.isHidden = true
        }
        
        
        }
    
    
    @IBAction func btnAnswer(_ sender: UIButton) {
        
        highlightSelectedButton(sender)
        btnNext.isHidden = false
        questions[currentQuestionIndex].userAnswers = sender.title(for: .normal)
        resetButtonStates()
        
        if currentQuestionIndex == questions.count - 1 {
                    btnSubmit.isHidden = false
                    btnNext.isHidden = true
                }
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        let selectedAnswer: String?
           
           if btnOption1.isSelected {
               selectedAnswer = btnOption1.title(for: .normal)
           } else if btnOption2.isSelected {
               selectedAnswer = btnOption2.title(for: .normal)
           } else if btnOption3.isSelected {
               selectedAnswer = btnOption3.title(for: .normal)
           } else if btnOption4.isSelected {
               selectedAnswer = btnOption4.title(for: .normal)
           } else {
               return
           }
        
           if selectedAnswer == questions[currentQuestionIndex].correct_answer {
               correctAnswersCount += 1
           }
           
           // Move to the next question
           currentQuestionIndex += 1
        print("updated index \(currentQuestionIndex)")
          
        if currentQuestionIndex == questions.count - 1 {
                    btnNext.isHidden = true
                    btnSubmit.isHidden = false
                } else {
                    btnNext.setTitle(">>>", for: .normal)
                }
           displayCurrentQuestion()
    }
    

    @IBAction func btnPrevious(_ sender: Any) {
        if currentQuestionIndex > 0 {
               currentQuestionIndex -= 1
               
               btnNext.setTitle(">>>", for: .normal)
               
               displayCurrentQuestion()
           }
    }
    
    func highlightSelectedButton(_ button: UIButton) {
            button.isSelected = true
            button.backgroundColor = .lightGray
        }
    
    func resetButtonStates() {
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    
                    if(questions[currentQuestionIndex].userAnswers == button.title(for: .normal)){
                        highlightSelectedButton(button)
                    }else{
                        button.isSelected = false
                        button.backgroundColor = .clear

                    }
                    }
            }
        }
    
    func showAlertForNextView(){
        let alert = UIAlertController(title: "Are you sure?", message: "Your quiz will be submitted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            
            self.performSegue(withIdentifier: "showResults", sender: self)
        })
                
                present(alert, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            if let destinationVC = segue.destination as? ResultViewController {
                            destinationVC.finalScore = correctAnswersCount
                            destinationVC.totalQuestions = questions.count
                        }
        }
    }


}





