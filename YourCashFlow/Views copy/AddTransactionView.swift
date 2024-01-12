//
//  AddTransactionView.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 12/27/23.
//

import SwiftUI

enum TranactionType {
    case income, expense
}

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var transactionType: TranactionType = .expense
    @State private var offset1: CGFloat = -60

    @State var inputSegment: String = ""
    @State var inputAmount: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    private let maxDigitsBeforeDecimal = 5
    private let maxDigitsAfterDecimal = 2
    private let maxDragDistance: CGFloat = 60
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer().padding()
                    Text("Choose Your Transaction Type").bold()
                    transactionTypeSelector
                    Spacer().padding()
                    segmentInputView
                    Spacer().padding()
                    Text("Enter Amount:").bold()
                    amountInputView
                    Text("Enter the amount of your transaction.").font(.caption).foregroundColor(.secondary)
                    saveButton
                }
                .navigationTitle("Add Transaction 📈")
                .alert(isPresented: $showAlert, content: getAlert)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("PrimeColor"), Color("AltColor")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }
    
    // Everything for the income/expense slider
    private var draggableColor: Color {
        let progress = (offset1 + maxDragDistance) / (2 * maxDragDistance)
        let redColor = Color.red
        let greenColor = Color.green
        return progress < 0.5 ? redColor.opacity(Double(1 - progress * 2)) : greenColor.opacity(Double((progress - 0.5) * 2))
    }
    
    
    private var transactionTypeSelector: some View {
        return ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 240,height: 60)
                    .foregroundColor(.secondary.opacity(0.3))
                RoundedRectangle(cornerRadius: 10)
                    .fill(draggableColor)
                    .frame(width: 110,height: 50)
                    .opacity(0.8)
                    .offset(x: offset1)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let dragAmount = gesture.translation.width
                                self.offset1 = dragAmount < -self.maxDragDistance ? -self.maxDragDistance : dragAmount > self.maxDragDistance ? self.maxDragDistance : dragAmount
                            }
                            .onEnded { _ in
                                if self.offset1 >= 0 {
                                    self.transactionType = .income
                                    self.offset1 = self.maxDragDistance
                                } else if self.offset1 < 0 {
                                    self.transactionType = .expense
                                    self.offset1 = -self.maxDragDistance
                                }
                            }
                    )
                    .animation(.easeIn, value: offset1)
                
                HStack {
                    
                    Text("Expense")
                        .bold()
                        .foregroundColor(transactionType == .expense ? Color("WhiteBlack") : Color("BlackWhite"))
                        .padding(25)
                    Spacer()
                    Text("Income")
                        .bold()
                        .foregroundColor(transactionType == .income ? Color("WhiteBlack") : Color("BlackWhite"))
                        .padding(25)
                }
                .frame(maxWidth: 240, maxHeight: 60)
            }
        }
    
    // Every thing for segments

    private var segmentInputView: some View {
        Group {
            if transactionType == .expense {
                ExpenseCategoryView(category: $inputSegment)
            } else {
                IncomeSourceView(source: $inputSegment)
            }
        }
    }
    
    
    // Everything for amount inpute
    
    private var amountInputView: some View {
        return HStack {
            TextField("00000.00", text: $inputAmount)
                .keyboardType(.decimalPad)
                .frame(width: 320, height: 80)
                .background(Color.secondary.opacity(0.3))
                .cornerRadius(100)
                .font(.system(size: 60))
                .multilineTextAlignment(.center)
                .onChange(of: inputAmount) { newValue in
                    var filtered = newValue.filter { "0123456789.".contains($0) }
                    let components = filtered.split(separator: ".", omittingEmptySubsequences: false)
                    if components.count > 2 {
                        inputAmount = String(inputAmount.prefix(inputAmount.count - 1))
                    } else {
                        if let integerPart = components.first, integerPart.count > maxDigitsBeforeDecimal {
                            filtered = String(integerPart.prefix(maxDigitsBeforeDecimal))
                            if components.count == 2 {
                                filtered += "." + components[1]
                            }
                        }
                        if components.count == 2, let decimalPart = components.last, decimalPart.count > maxDigitsAfterDecimal {
                            filtered = String(components[0]) + "." + decimalPart.prefix(maxDigitsAfterDecimal)
                        }
                        inputAmount = filtered
                    }
                }
        }
        .frame(maxWidth: 360, maxHeight: 80, alignment: .center)
    }

    
    // Everything for Save button
    
    private var inputIsIncome: Bool {
            return transactionType == .income
    }
    
    private var formattedAmount: String {
        let numericValue = Double(inputAmount) ?? 0
        return String(format: "$%.2f", numericValue)
    }
    
    private var saveButton: some View {
        return Button(action: saveButtonPressed, label: {
            Text("Save".uppercased())
                .foregroundColor(.white).font(.headline)
                .frame(height: 55)
                .frame(maxWidth: 320)
                .background(Color("PrimeColor"))
                .cornerRadius(10)
            
        })
    }

    // End of everyting in the body
    
    
    // All functions below
    func saveButtonPressed() {
        if isSegmentValid() && isAmountValid() {
            if let doubleAmount = Double(inputAmount) {
                listViewModel.addItem(isIncome: inputIsIncome, amount: doubleAmount, segement: inputSegment, data: Date())
                presentationMode.wrappedValue.dismiss()
            } else {
                alertTitle = "Invalid amount input"
                showAlert.toggle()
            }
        }
    }
    
    func isSegmentValid() -> Bool {
        if inputSegment.isEmpty {
            alertTitle = "Make sure to enter the category or source to continue 🤔"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func isAmountValid() -> Bool {
        if inputAmount.isEmpty {
            alertTitle = "Make sure to enter the amount of your transaction 🫣"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

    
struct ExpenseCategoryView: View {
    @Binding var category: String

    var body: some View {
        VStack {
            Text("Enter Your Expense Category:")
                .bold()
            TextField("e.g., Groceries, Utilities, Rent...", text: $category)
                .padding(.horizontal)
                .frame(width: 320, height: 60)
                .background(Color.secondary.opacity(0.3))
                .multilineTextAlignment(.center)
                .cornerRadius(10)
            Text("Enter a category for your expense.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct IncomeSourceView: View {
    @Binding var source: String

    var body: some View {
        VStack {
            Text("Enter Your Income Source:")
                .bold()
            TextField("e.g., Paycheck, Cash, Gig...", text: $source)
                .padding(.horizontal)
                .frame(width: 320, height: 60)
                .background(Color.secondary.opacity(0.3))
                .multilineTextAlignment(.center)
                .cornerRadius(10)
            Text("Enter a source for your income.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}


struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTransactionView()
        }
        .environmentObject(ListViewModel())
    }
}
