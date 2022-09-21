//
//  QuestionGroupCell.swift
//  DesignPatternRay
//
//  Created by master on 9/14/22.
//

import UIKit
import Combine

public class QuestionGroupCell: UITableViewCell {
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var percentageLabel: UILabel!
    
    public static var resuseID = "QuestionGroupCell"
    public var percentageSubscriber: AnyCancellable?
}
