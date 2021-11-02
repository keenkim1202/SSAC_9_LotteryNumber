//
//  LottoViewController.swift
//  LotteryNumber
//
//  Created by KEEN on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

// TODO: 최신 회차정보 자동으로 가져오기 - 현재 날짜를 기준으로 매주 토요일 정보 가져오기.

class LottoViewController: UIViewController {
  
  // MARK: - Properties
  let latestDraw: Int = getDrawNum()
  let pickerView = UIPickerView()
  let progress = JGProgressHUD()
  var selected = ""
  var pickerData = Array<Int>()
  
  // MARK: - UI
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var drawNoLabel: UILabel!
  
  @IBOutlet weak var no1Label: UILabel!
  @IBOutlet weak var no2Label: UILabel!
  @IBOutlet weak var no3Label: UILabel!
  @IBOutlet weak var no4Label: UILabel!
  @IBOutlet weak var no5Label: UILabel!
  @IBOutlet weak var no6Label: UILabel!
  @IBOutlet weak var bonusLabel: UILabel!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setPickerView()
    
    cardView.layer.addBorder([.bottom], color: UIColor(named: "BorderColor") ?? UIColor.lightGray, width: 1)
    fetchLotteryNumber(latestDraw)
    selected = "\(latestDraw)"
    textField.text = selected
  }

  func setPickerView() {
    pickerView.delegate = self
    pickerView.dataSource = self
    
    pickerData = Array<Int>(1...latestDraw).reversed()
    
    // picker toolbar
    let pickerToolbar : UIToolbar = UIToolbar()
    pickerToolbar.barStyle = .default
    pickerToolbar.isTranslucent = true
    pickerToolbar.backgroundColor = .lightGray
    pickerToolbar.sizeToFit()
    
    // picker toolbar button
    let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
    pickerToolbar.setItems([btnCancel , space , btnDone], animated: true)
    pickerToolbar.isUserInteractionEnabled = true
    
    textField.inputView = pickerView
    textField.inputAccessoryView = pickerToolbar
  }
  
  // MARK: - Configure
  func configureBall(_ label: UILabel, number: Int) {
    if let ballView = label.superview {
      if number <= 10 { // yellow
        ballView.backgroundColor = UIColor(named: "YellowBallColor")
      } else if number > 10 && number <= 20 { // blue
        ballView.backgroundColor = UIColor(named: "BlueBallColor")
      } else if number > 20 && number <= 30 { // red
        ballView.backgroundColor = UIColor(named: "RedBallColor")
      } else if number > 30 && number <= 40 { // gray
        ballView.backgroundColor = UIColor(named: "GrayBallColor")
      } else { // green
        ballView.backgroundColor = UIColor(named: "GreenBallColor")
      }
      label.text = "\(number)"
      ballView.layer.cornerRadius = ballView.layer.frame.size.width / 2
    }
  }
  
  @objc func onPickDone() {
    progress.show(in: view, animated: true)
    
    if selected != textField.text {
      textField.text = selected
      fetchLotteryNumber(Int(selected)!)
    }
    textField.resignFirstResponder()
    progress.dismiss(animated: true)
  }
  
  @objc func onPickCancel() {
    textField.resignFirstResponder()
    textField.text = ""
  }
  
  // MARK: - fetch Data
  func fetchLotteryNumber(_ drawNo: Int) {
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawNo)"
    print(url)
    AF.request(url, method: .get).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        
        // TODO: 반복적인 부분을 더 줄여 주고 싶음🤔
        self.configureBall(self.no1Label, number: json["drwtNo1"].intValue)
        self.configureBall(self.no2Label, number: json["drwtNo2"].intValue)
        self.configureBall(self.no3Label, number: json["drwtNo3"].intValue)
        self.configureBall(self.no4Label, number: json["drwtNo4"].intValue)
        self.configureBall(self.no5Label, number: json["drwtNo5"].intValue)
        self.configureBall(self.no6Label, number: json["drwtNo6"].intValue)
        self.configureBall(self.bonusLabel, number: json["bnusNo"].intValue)
        
        self.dateLabel.text = "\(json["drwNoDate"].stringValue) 추첨"
        self.drawNoLabel.text = "\(json["drwNo"].stringValue)회"
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
}

// MARK: - Extension - PickerView Delegate & DataSource
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(pickerData[row])
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selected = String(pickerData[row])
  }
  
}
