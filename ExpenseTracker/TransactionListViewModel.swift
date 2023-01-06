//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Hanamantraya Nagonde on 06/01/23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPreffixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getTranscation()
    }
    
    func getTranscation() {
//        guard let url = URL(string: "https://designcode.io/date/transcation.json") else {
//            print("Invalid url address")
//            return
//        }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap {(data, response) -> Data in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    dump(response)
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: [Transaction].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion{
//                case .failure(let error):
//                    print("Error while fetching transcation", error.localizedDescription)
//                case .finished:
//                    print("Finished fetching transcation")
//                }
//            } receiveValue: { [weak self] result in
//                self?.transaction = result
//                dump(self?.transaction)
//            }
//            .store(in: &cancellable)
        
        guard let url = Bundle.main.url(forResource: "transactions", withExtension: "json") else {
            print("Json file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        guard let data = data else { return }
        let transactions = try? JSONDecoder().decode([Transaction].self, from: data)
        guard let transactions = transactions else { return }
        self.transactions = transactions

    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        let groupTransactions = TransactionGroup(grouping: transactions) { $0.month }
        return groupTransactions
    }
    
    func accumulateTransactions() -> TransactionPreffixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return[] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPreffixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedToTwoDigit()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum", sum)
        }
        return cumulativeSum
    }
}
