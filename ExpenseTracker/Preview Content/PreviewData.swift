//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Hanamantraya Nagonde on 05/01/23.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Amerian Express", account: "Visa American Express", merchant: "Apple", amount: 1026.9, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
