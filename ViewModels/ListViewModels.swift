//
//  ListViewModels.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 12/29/23.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var transactions: [FinancialDataModel] = [] {
        didSet {
            saveTransactions()
        }
    }
    @Published var summary: FinancialSummaryModel {
        didSet {
            saveSummary()
        }
    }
    
    let transactionsKey: String = "transations_list"
    let summaryKey: String = "summaryKey"
    
    
    init() {
        self.summary = FinancialSummaryModel()
        loadTransactions()
        loadSummary()
    }
    
    func loadTransactions() {
        guard
            let data = UserDefaults.standard.data(forKey: transactionsKey),
            let savedTransactions = try? JSONDecoder().decode([FinancialDataModel].self, from: data)
        else { return }

        self.transactions = savedTransactions
    }

    func loadSummary() {
        guard
            let data = UserDefaults.standard.data(forKey: summaryKey),
            let savedSummary = try? JSONDecoder().decode(FinancialSummaryModel.self, from: data)
        else { return }

        self.summary = savedSummary
    }
        
    func deleteItem(indexSet: IndexSet) {
        for index in indexSet {
            let transaction = transactions[index]
            removeSummary(transaction: transaction)
            transactions.remove(at: index)
        }
    }
    
    func addItem(isIncome: Bool, amount: Double, segement: String, data: Date) {
        let newItem = FinancialDataModel(isIncome: isIncome,amount: amount, segment: segement, date: Date())
        transactions.append(newItem)
        updateSummary(with: newItem)
    }
    
    // Sorting Functions
    
    func sortByDate(reverse: Bool = false) {
        transactions.sort {
            reverse ? $0.date < $1.date : $0.date > $1.date
        }
    }
    
    func sortByAmount(reverse:Bool = false) {
        transactions.sort {
            reverse ? $0.amount < $1.amount : $0.amount > $1.amount
        }
    }
    
    func sortByIncomeExpense(reverse:Bool = false) {
        transactions.sort {
            if reverse {
                return !$0.isIncome && $1.isIncome
            } else {
                return $0.isIncome && !$1.isIncome
            }
        }
    }
    
    
    // For Financial Summary Model
    func updateSummary(with transaction: FinancialDataModel) {
        if transaction.isIncome {
            summary.totalIncomes += transaction.amount
            summary.currentAmount += transaction.amount
            summary.countIncome += 1
            summary.countTransactions += 1
        } else {
            summary.totalExpenses += transaction.amount
            summary.currentAmount -= transaction.amount
            summary.countExpenses += 1
            summary.countTransactions += 1
        }
    }

    func removeSummary(transaction: FinancialDataModel) {
        if transaction.isIncome {
            summary.totalIncomes -= transaction.amount
            summary.currentAmount -= transaction.amount
            summary.countIncome -= 1
            summary.countTransactions -= 1
        } else {
            summary.totalExpenses -= transaction.amount
            summary.currentAmount += transaction.amount
            summary.countExpenses -= 1
            summary.countTransactions -= 1
        }
    }
    
    func saveTransactions() {
        if let encodedData = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encodedData, forKey: transactionsKey)
        }
    }

    func saveSummary() {
        if let encodedData = try? JSONEncoder().encode(summary) {
            UserDefaults.standard.set(encodedData, forKey: summaryKey)
        }
    }

}
