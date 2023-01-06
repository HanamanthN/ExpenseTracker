//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Hanamantraya Nagonde on 07/01/23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Group
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month, transaction in
                    Section {
                        // MARK: Transaction List
                        ForEach(transaction) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        // MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        NavigationView {
            TransactionList()
                .environmentObject(transactionListVM)
        }
    }
}
