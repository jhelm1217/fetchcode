//
//  MealViewModel.swift
//  Fetch
//
//  Created by Jacinta Helm on 8/1/24.
//

import Foundation

@MainActor
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealDetail?
    
    func fetchDesserts() async {
        do {
            meals = try await APIService.shared.fetchDesserts()
        } catch {
            print("Failed to fetch desserts: \(error)")
        }
    }
    
    func fetchMealDetail(id: String) async {
        do {
            selectedMealDetail = try await APIService.shared.fetchMealDetail(id: id)
        } catch {
            print("Failed to fetch meal detail: \(error)")
        }
    }
}

