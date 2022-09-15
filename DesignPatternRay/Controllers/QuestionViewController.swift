//
//  ViewController.swift
//  DesignPatternRay
//
//  Created by master on 9/13/22.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy, at questionIndex: Int)
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    public weak var delegate: QuestionViewControllerDelegate?
    
    public var questionStragegy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStragegy.title
        }
    }
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionStragegy.currentQuestion()
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStragegy.questionIndexTitle()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStragegy, at: questionIndex)
    }
    
    // MARK: - IBAction Methods
    @IBAction func toggleAnswerLabels() {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        let question = questionStragegy.currentQuestion()
        questionStragegy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = String(questionStragegy.correctCount)
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = questionStragegy.currentQuestion()
        questionStragegy.markQuestionIncorrect(question)
        
        questionView.incorrectCountLabel.text = String(questionStragegy.incorrectCount)
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            delegate?.questionViewController(self, didComplete: questionStragegy)
            return
        }
        showQuestion()
    }
}

