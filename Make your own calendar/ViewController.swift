//
//  ViewController.swift
//  Make your own calendar
//
//  Created by Konda Reddy on 08/08/18.
//  Copyright © 2018 Valuesol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var calendarCollectionView:UICollectionView!
    @IBOutlet var monthLabel:UILabel!
    @IBOutlet var yearLabel:UILabel!
    @IBOutlet var previousButton:UIButton!
    @IBOutlet var nextButton:UIButton!
    @IBOutlet var todayButton:UIButton!
    
    var daysArray:[String] = []
    
    var currentYear:Int = 0
    var currentMonth:Int = 0
    var currentDay:Int = 0
    var n = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todayDate()
        self.updateDate()
        
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.dataSource = self
    }
    
    //-----Button Action----//
    //     previousButton
    @IBAction func previousButtonTapped(){
        self.daysArray = []
        self.n = 0
        if  self.currentMonth != 1{
            self.currentMonth = self.currentMonth - 1
        }
        else{
            self.currentYear = self.currentYear-1
            self.currentMonth = 12
        }
        self.updateDate()
        self.calendarCollectionView.reloadData()
    }
    
    //    NextButton
    @IBAction func nextButtonTapped(){
        self.daysArray = []
        self.n = 0
        if  self.currentMonth != 12{
            self.currentMonth = self.currentMonth + 1
        }
        else{
            self.currentYear = self.currentYear + 1
            self.currentMonth = 1
        }
        self.updateDate()
        self.calendarCollectionView.reloadData()
    }
    
    //   Today Button
    @IBAction func todayButtonTapped(){
        self.daysArray = []
        self.n = 0
        self.todayDate()
        self.updateDate()
        self.calendarCollectionView.reloadData()
    }
    
    @IBAction func backButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //**************************************************//
    //-------------Calculate Data Methods---------------//
    //**************************************************//
    
    //Today Date
    func todayDate(){
        let date = Date()
        let calendar = Calendar.current
        
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.currentDay = calendar.component(.day, from: date)
        print(self.currentYear)
    }
    
    //Update Date Array
    func updateDate(){
        self.yearLabel.text = ("\(self.currentYear)")
        let weekday = (getDayOfWeek(today: "\(currentYear)-\(currentMonth)-1"))-1
        var i = 1
        while i <= weekday {
            self.daysArray.append(" ")
            i = i + 1
        }
        
        let NoofDays = (GetNoofDays(CMonth: self.currentMonth)!)
        var j = 1
        while j <= NoofDays {
            self.daysArray.append("\(j)")
            j = j + 1
        }
    }
    
    // Get Current month Starting Day
    func getDayOfWeek(today:String)->Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    
    //Get Number of days in current Month
    func GetNoofDays(CMonth: Int)->Int?{
        switch CMonth{
        case 1:
            self.monthLabel.text = "January"
            return 31
        case 2:
            self.monthLabel.text = "February"
            if (self.currentYear % 4 == 0){
                return 29
            }
            return 28
        case 3:
            self.monthLabel.text = "March"
            return 31
        case 4:
            self.monthLabel.text = "April"
            return 30
        case 5:
            self.monthLabel.text = "May"
            return 31
        case 6:
            self.monthLabel.text = "June"
            return 30
        case 7:
            self.monthLabel.text = "July"
            return 31
        case 8:
            self.monthLabel.text = "August"
            return 31
        case 9:
            self.monthLabel.text = "September"
            return 30
        case 10:
            self.monthLabel.text = "October"
            return 31
        case 11:
            self.monthLabel.text = "November"
            return 30
        case 12:
            self.monthLabel.text = "December"
            return 31
        default:
            self.monthLabel.text = ""
            return 0
        }
    }
}
// ----------------------------------------------------------------------------//
// -------------Extension methods for Calendar Collection view-----------------//
// ----------------------------------------------------------------------------//

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        
        cell.dateLabel.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.dateLabel.text = self.daysArray[indexPath.row]

        return cell
    }
    
}
