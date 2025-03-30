//
//  AddQuestionViewController.swift
//  Asssignment3
//
//  Created by Ishika on 2025-03-21.
//

import UIKit

protocol AddingNewQuestionDelegate {
    func addingNewQuestionDidFinishWithQuestionObject(newQuestion: Question)
    func addingNewStudentDidCancel()
}

protocol UpdatingQuestionDelegate{
    func updateNewQuestionDidFinishWith(updatedQuestion: Question)
    func updateNewQuestionDidCancel()
}

class AddQuestionViewController: UIViewController {

    var delegate: AddingNewQuestionDelegate?
    var updateDelegate: UpdatingQuestionDelegate?
    var questionToUpdate: Question?
    
    
    @IBOutlet weak var questionText: UITextField!
    
    
    @IBOutlet weak var correctanswerText: UITextField!
    
    
    
    @IBOutlet weak var choice1Text: UITextField!
    
    
    
    @IBOutlet weak var choice2Text: UITextField!
    
    
    
    @IBOutlet weak var choice3Text: UITextField!
    
    var model: QuestionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = ((UIApplication.shared.delegate) as! AppDelegate).myModel
        
        if questionToUpdate != nil{
            questionText.text = questionToUpdate?.question
            correctanswerText.text = questionToUpdate?.correct_answer
            choice1Text.text = questionToUpdate?.choices[0]
            choice2Text.text = questionToUpdate?.choices[1]
            choice3Text.text = questionToUpdate?.choices[0]
        }
    }
    
    
    @IBAction func BtnCan(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "New changes will not be added in question bank.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            
            self.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func SaveNewQuestion(_ sender: Any) {
        if let question = questionText.text,
               let correctAnswerText = correctanswerText.text,
               let choice1 = choice1Text.text,
               let choice2 = choice2Text.text,
               let choice3 = choice3Text.text {
                
                if !question.isEmpty, !correctAnswerText.isEmpty, !choice1.isEmpty, !choice2.isEmpty, !choice3.isEmpty {
                    let alert = UIAlertController(title: "Are you sure?", message: "The question will be saved.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               
                        let choices = [choice1, choice2, choice3]
                        
                        if let existingQuestion = self.questionToUpdate {
                      
                            existingQuestion.question = question
                            existingQuestion.correct_answer = correctAnswerText
                            existingQuestion.choices = choices
                            
                            // Notify the update delegate
                            self.updateDelegate?.updateNewQuestionDidFinishWith(updatedQuestion: existingQuestion)
                        } else {
                            // Create a new Question object
                            let newQuestion = Question(question: question, correct_answer: correctAnswerText, choices: choices)
                            // Add the new question to the model
                            self.model?.addNewQuestion(newQuestion: newQuestion)
                            
                            self.delegate?.addingNewQuestionDidFinishWithQuestionObject(newQuestion: newQuestion)
                        }
                        
                        
                        self.dismiss(animated: true, completion: nil)
                    }))
                    
                    present(alert, animated: true, completion: nil)
                } else {
                    // Handle case where fields are empty
                    let errorAlert = UIAlertController(title: "Error", message: "Please fill in all fields.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(errorAlert, animated: true, completion: nil)
                }
            }
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
