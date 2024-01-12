//
//  ListRowView.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 12/26/23.
//

import SwiftUI

struct ListRowView: View {
    
    let transaction: FinancialDataModel
    
    var body: some View {
        HStack (alignment: .center){
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(transaction.isIncome ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                    .frame(width: 160, height: 40)
                    .cornerRadius(10)
                
                Text(String(format: "$%.2f", transaction.amount))
                    .frame(width:155)
                    .lineLimit(1)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
            Spacer()
            VStack (alignment: .trailing) {
                Text("\(transaction.segment)")
                    .font(.subheadline)
                    .bold()
                Text(transaction.date, style: .date)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .scrollContentBackground(.hidden)
    }
}



struct ListRowView_Previews: PreviewProvider {
    
    static var transaction1 = FinancialDataModel(isIncome: true, amount: 100.1, segment: "Salary", date: Date())
    static var transaction2 = FinancialDataModel(isIncome: false, amount: 200.0, segment: "Car Payment", date: Date())
    
    static var previews: some View {
        Group {
            ListRowView(transaction: transaction1)
            ListRowView(transaction: transaction2)
        }
    }
}
