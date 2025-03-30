import UIKit

class QuestionsTableViewController: UITableViewController, AddingNewQuestionDelegate, UpdatingQuestionDelegate {
    
    var model: QuestionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ((UIApplication.shared.delegate) as! AppDelegate).myModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.questionsList.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qcell", for: indexPath) as! QuestionTableViewCell
        
        let question = model?.questionsList[indexPath.row]
           
           cell.questionTextField.text = question?.question
           cell.correctAnswerTextField.text = question?.correct_answer
           
        if let choices = question?.choices {
                cell.choice1TextField.text = choices.count > 0 ? choices[0] : ""
                cell.choice2TextField.text = choices.count > 1 ? choices[1] : ""
                cell.choice3TextField.text = choices.count > 2 ? choices[2] : ""
            } else {
                // Clear the choice text fields if no choices are available
                cell.choice1TextField.text = ""
                cell.choice2TextField.text = ""
                cell.choice3TextField.text = ""
            }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func addingNewQuestionDidFinishWithQuestionObject(newQuestion: Question) {
//        model?.addNewQuestion(newQuestion: newQuestion)
        tableView.reloadData()
    }
    
    func addingNewStudentDidCancel() {
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let idToDelete = model?.questionsList[indexPath.row].id else { return }
            model?.deleteOneQuestion(idToDelete: idToDelete)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddQuestionSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddQuestionSegue" { 
            if let addingVC = segue.destination as? AddQuestionViewController {
                addingVC.delegate = self
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    addingVC.updateDelegate = self
                    addingVC.questionToUpdate = model?.questionsList[selectedIndex.row]
                    tableView.deselectRow(at: selectedIndex, animated: false)
                }
            }
        }
    }

    
    
    func updateNewQuestionDidFinishWith(updatedQuestion: Question) {
        model?.updateQuestion(updatedQuestion: updatedQuestion)
        tableView.reloadData()
    }
    
    func updateNewQuestionDidCancel() {
        // Handle cancellation if needed
    }
    
    

}
