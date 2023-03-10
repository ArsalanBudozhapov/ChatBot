//
//  APIManager.swift
//  ChatBot
//
//  Created by мак on 25.01.2023.
//

import Foundation
import OpenAISwift

final class APIManager {
    static let shared = APIManager()
    
    @frozen enum Constants {
        static let secretKey: String = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.secretKey)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                print("Successfully generated response")
                let aiResponse = model.choices.first?.text ?? "ERROR: could not load response"
                completion(.success(aiResponse))
            case .failure(let error):
                completion(.failure(error))
                print("ERROR: \(error.localizedDescription)")
            default:
                print("Unknown case in APIManager: getResponse - result")
            }
        })
    }
    
}
