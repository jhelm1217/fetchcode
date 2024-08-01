//
//  APIService.swift
//  Fetch
//
//  Created by Jacinta Helm on 8/1/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealListResponse.self, from: data)
        return response.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return response.meals.first!
    }
}

