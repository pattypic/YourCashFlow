//
//  FinancialModel.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 12/29/23.
//

import Foundation

struct FinancialDataModel: Identifiable, Codable{
    var id: String = UUID().uuidString
    var isIncome: Bool
    var amount: Double
    var segment: String
    var date: Date
    
    init(isIncome: Bool, amount: Double, segment: String, date: Date) {
        self.isIncome = isIncome
        self.amount = amount
        self.segment = segment
        self.date = date
    }
}
