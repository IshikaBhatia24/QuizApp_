//
//  ModelClasses.swift
//  Asssignment3
//
//  Created by Ishika on 2025-03-21.
//

import Foundation

class Question{
    var id : UUID = UUID()
    var question : String?
    var correct_answer : String?
    var choices : [String]
    var userAnswers : String?
    
    init(question: String? = nil, correct_answer: String? = nil, choices: [String]) {
        self.question = question
        self.correct_answer = correct_answer
        self.choices = choices
        self.userAnswers = nil
    }
}

class QuestionManager {
    
    static var shared = QuestionManager()
    var questionsList: [Question] = []
    
    func addNewQuestion(newQuestion: Question){
        questionsList.append(newQuestion)
    }
    
    func updateQuestion(updatedQuestion: Question){
        let index = questionsList.firstIndex{ question in
            return question.id == updatedQuestion.id
        }
        if index != nil {
            questionsList[index!] = updatedQuestion
        }
    }
    
    func deleteOneQuestion(idToDelete: UUID){
        questionsList.removeAll{ question in
            return question.id == idToDelete
        }
    }
}
