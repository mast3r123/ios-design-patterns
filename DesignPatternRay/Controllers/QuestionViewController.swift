//
//  ViewController.swift
//  DesignPatternRay
//
//  Created by master on 9/13/22.
//

import UIKit

public class QuestionViewController: UIViewController {
    
    public var questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
}

