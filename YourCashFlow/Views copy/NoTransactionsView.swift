//
//  NoTransactionsView.swift
//  YourCashFlow
//
//  Created by Patrick Pichardo on 1/9/24.
//

import SwiftUI

struct NoTransactionsView: View {
    
    @State var animate: Bool = false
    
    var plus: some View {
        Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .frame(width: 75, height: 75)
            .foregroundColor(Color("WhiteBlack"))
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "tray.full")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)

                Text("Welcome to YourCashFlow!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Get started by adding your income and expenses using the '+'. Track your cash flow, manage your finances, and see where your money goes!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding(.horizontal, 20)
        
                NavigationLink(
                    destination: AddTransactionView(),
                    label: {
                        ZStack {
                            plus
                                .frame(width: 125, height: 125)
                                .background(animate ? Color.red : Color.primary)
                                .cornerRadius(10)
                        }
                    })
                .shadow(color: animate ? Color.red.opacity(0.7) : Color.primary.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0.0,
                        y: 0.0)
                .scaleEffect(animate ? 1.1 : 1.0)
                .padding(.top, 50)
            }
            .multilineTextAlignment(.center)
            .padding(10)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}

struct NoTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoTransactionsView()
                .navigationTitle("Title")
        }
    }
}
