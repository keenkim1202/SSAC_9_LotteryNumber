//
//  WinningNoTableViewCell.swift
//  LotteryNumber
//
//  Created by KEEN on 2021/10/27.
//

import UIKit

class WinningNoTableViewCell: UITableViewCell {
  
  static let identifier = "winnigNoCell"
  
  @IBOutlet weak var no1Label: UILabel!
  @IBOutlet weak var no2label: UILabel!
  @IBOutlet weak var no4Label: UILabel!
  @IBOutlet weak var no5Label: UILabel!
  @IBOutlet weak var no3Label: UILabel!
  @IBOutlet weak var no6Label: UILabel!
  @IBOutlet weak var bonusLabel: UIView!
  
  
  func cellConfigure(_ labels: [UILabel]) {
    
  }
}
