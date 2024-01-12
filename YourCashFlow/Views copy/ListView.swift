//
//  ListView.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 12/26/23.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var sortByDateOrder: SortOrder? = nil
    @State private var sortByAmountOrder: SortOrder? = nil
    @State private var sortByType: SortType? = nil
    
    enum SortOrder {
        case ascending, descending
    }
    
    enum SortType {
        case incomeFirst, expenseFirst
    }
    
    var plus: some View {
        Image(systemName: "plus")
            .font(.title3)
            .foregroundColor(.primary)
            .padding()
        
    }
    
    var menu: some View {
        Image(systemName: "line.horizontal.3")
            .font(.title3)
            .foregroundColor(.primary)
            .padding()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                 gradient: Gradient(colors:[
                    Color("PrimeColor"),
                    Color("AltColor")]),
                 startPoint: .topLeading,
                 endPoint: .bottomTrailing
             ).edgesIgnoringSafeArea(.all)
            
            if listViewModel.transactions.isEmpty {
                NoTransactionsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                   Section{
                       HStack {
                           Spacer()
                           VStack(alignment: .center) {
                               Text("YourAccount")
                                   .font(.title2)
                                   .fontWeight(.bold)
                               Text("\(listViewModel.summary.currentAmount, specifier: "$%.2f")")
                                   .font(.largeTitle)
                           }
                           Spacer()
                       }
                       HStack (alignment: .center){
                           Spacer()
                           Text("Total Expenses: \(listViewModel.summary.countExpenses)")
                           Text("Total Incomes: \(listViewModel.summary.countIncome)")
                           Spacer()
                       }
                   }
                    
                    sortByTypeButton
                    sortByDateButton
                    sortByAmountButton
                

                   Section {
                       Text("Transactions")
                           .font(.title2)
                           .fontWeight(.bold)
                       ForEach(listViewModel.transactions) { transaction in
                           ListRowView(transaction: transaction)
                               .frame(maxHeight: 35)
                       }
                       .onDelete(perform: listViewModel.deleteItem)
                   }
               }
               .listStyle(InsetGroupedListStyle())
               .scrollContentBackground(.hidden)
            }
        }
        
       .navigationTitle("YourCashFlow 💰")
       .navigationBarItems(
//           leading: NavigationLink(destination: MenuView()) { menu },
           trailing: NavigationLink(destination: AddTransactionView()) { plus }
       )
        
   }
    
    
    private var sortByTypeButton: some View {
        Button(action: {
            switch sortByType {
            case .incomeFirst:
                sortByType = .expenseFirst
                listViewModel.sortByIncomeExpense(reverse: true)
            default:
                sortByType = .incomeFirst
                listViewModel.sortByIncomeExpense(reverse: false)
            }
            
            sortByDateOrder = nil
            sortByAmountOrder = nil
        }) {
            HStack(alignment: .center) {
                Text("Sort by Expense/Income")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, maxHeight: 25)
                    .foregroundColor(Color("BlackWhite"))
                    .background(sortByType != nil ? (sortByType == .incomeFirst ? Color.green.opacity(0.8) : Color.red.opacity(0.8)) : Color("PrimeColor").opacity(0.7))
                    .cornerRadius(10)
            }
        }
    }
    
    private var sortByDateButton: some View {
        Button(action: {
            sortByDateOrder = sortByDateOrder == .ascending ? .descending : .ascending
            let reverse = sortByDateOrder == .descending
            listViewModel.sortByDate(reverse: reverse)
            
            sortByType = nil
            sortByAmountOrder = nil
            
        }) {
            HStack(alignment: .center) {
                Text("Sort by Date")
                Image(systemName: sortByDateOrder == .ascending ? "arrow.up" : "arrow.down")
                    .opacity(sortByDateOrder != nil ? 1 : 0)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, maxHeight: 25)
            .foregroundColor(Color("BlackWhite"))
            .background(Color("PrimeColor").opacity(0.7))
            .cornerRadius(10)

        }
    }
    
    private var sortByAmountButton: some View {
        Button(action: {
            sortByAmountOrder = sortByAmountOrder == .ascending ? .descending : .ascending
            let reverse = sortByAmountOrder == .descending
            listViewModel.sortByAmount(reverse: reverse)

            sortByType = nil
            sortByDateOrder = nil
        }) {
            HStack(alignment: .center) {
                Text("Sort by Amount")
                Image(systemName: sortByAmountOrder == .ascending ? "arrow.up" : "arrow.down")
                    .opacity(sortByAmountOrder != nil ? 1 : 0)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, maxHeight: 25)
            .foregroundColor(Color("BlackWhite"))
            .background(Color("PrimeColor").opacity(0.7))
            .cornerRadius(10)
        }
    }
    
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

