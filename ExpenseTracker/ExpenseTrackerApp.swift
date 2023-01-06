//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Hanamantraya Nagonde on 05/01/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transcationListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transcationListVM)
        }
    }
}
