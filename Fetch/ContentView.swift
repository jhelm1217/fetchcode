//
//  ContentView.swift
//  Fetch
//
//  Created by Jacinta Helm on 8/1/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    Text(meal.strMeal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchDesserts()
            }
        }
    }
}

struct MealDetailView: View {
    let meal: Meal
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let mealDetail = viewModel.selectedMealDetail {
                    Text(mealDetail.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let imageUrl = mealDetail.strMealThumb, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(maxWidth: .infinity)
                                 .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text("Instructions")
                        .font(.headline)
                    Text(mealDetail.strInstructions)
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(0..<20) { index in
                        if let ingredient = mealDetail.value(forKey: "strIngredient\(index + 1)") as? String, !ingredient.isEmpty,
                           let measure = mealDetail.value(forKey: "strMeasure\(index + 1)") as? String, !measure.isEmpty {
                            Text("\(ingredient): \(measure)")
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .task {
                await viewModel.fetchMealDetail(id: meal.idMeal)
            }
        }
        .navigationTitle(meal.strMeal)
        .navigationBarTitleDisplayMode(.inline)
    }
}
