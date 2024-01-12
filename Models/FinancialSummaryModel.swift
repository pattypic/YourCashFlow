//
//  FinancialSummary.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 1/5/24.
//

import Foundation

struct FinancialSummaryModel: Codable {
    var currentAmount: Double = 0.0 // the combination of expenses and income
    var totalExpenses: Double = 0.0 // total Value of Expenses
    var totalIncomes: Double = 0.0  // total value of Income
    var countExpenses: Int = 0      // tot num of expenses
    var countIncome: Int = 0        // tot nim of incomes
    var countTransactions: Int = 0  // tot num of all trans acts
}
