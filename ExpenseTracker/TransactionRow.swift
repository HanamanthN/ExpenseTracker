//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Hanamantraya Nagonde on 05/01/23.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    @Environment(\.colorScheme) var colorScheme
    var transaction: Transaction
    var body: some View {
        HStack(spacing: 24) {
            /// MARK:- Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon)
                .opacity(0.3)
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            VStack(alignment: .leading, spacing: 6) {
                /// MARK:- Transaction Merchent
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                /// MARK:- Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                /// MARK:- Transaction Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            /// MARK:- Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? .text : colorScheme == .dark ? .white : .black)
                .bold()
        }.padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionPreviewData)
    }
}
